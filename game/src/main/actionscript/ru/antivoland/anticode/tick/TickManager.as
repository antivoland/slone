/**
 * @author antivoland
 */
package ru.antivoland.anticode.tick {
import flash.display.Stage;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.getTimer;

import ru.antivoland.anticode.Callback;

[Event(name="tick", type="ru.antivoland.anticode.tick.TickEvent")]
[Event(name="slowTick", type="ru.antivoland.anticode.tick.TickEvent")]
[Event(name="fps", type="ru.antivoland.anticode.tick.TickEvent")]
public class TickManager extends EventDispatcher {
    private static const TICK_DELAY_MILLIS:int = 30;
    private static const SLOW_TICK_DELAY_MILLIS:int = 500;
    private static const FPS_DELAY_MILLIS:int = 1000;

    private var tickInterval:int = TICK_DELAY_MILLIS;
    private var fps:int = 0;
    private var lastTickMillis:int;
    private var lastSlowTickMillis:int;
    private var lastFpsMillis:int;
    private var frames:int;

    public function TickManager(stage:Stage) {
        var nowMillis:int = getTimer();
        this.lastTickMillis = nowMillis;
        this.lastSlowTickMillis = nowMillis;
        this.lastFpsMillis = nowMillis;
        this.frames = 0;
        stage.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
    }

    public function setTickInterval(tickInterval:int):void {
        this.tickInterval = tickInterval;
    }

    public function getFps():int {
        return fps;
    }

    public function delay(interval:int, callback:Function):void {
        var time:int = 0;
        addEventListener(TickEvent.TICK, handleDelayTick);

        function handleDelayTick(event:TickEvent):void {
            time += event.getDt();
            if (time > interval) {
                removeEventListener(TickEvent.TICK, handleDelayTick);
                Callback.invoke(callback, true);
            }
        }
    }

    private function handleEnterFrame(event:Event):void {
        var nowMillis:int = getTimer();
        var dt:int = nowMillis - lastTickMillis;
        if (dt >= tickInterval) {
            lastTickMillis = nowMillis;
            dispatchEvent(new TickEvent(TickEvent.TICK, dt));
        }

        dt = nowMillis - lastSlowTickMillis;
        if (dt >= SLOW_TICK_DELAY_MILLIS) {
            lastSlowTickMillis = nowMillis;
            dispatchEvent(new TickEvent(TickEvent.SLOW_TICK, dt));
        }

        ++frames;
        dt = nowMillis - lastFpsMillis;
        if (dt >= FPS_DELAY_MILLIS) {
            lastFpsMillis = nowMillis;
            fps = frames;
            frames = 0;
            dispatchEvent(new TickEvent(TickEvent.FPS, dt));
        }
    }
}
}
