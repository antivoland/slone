/**
 * @author antivoland
 */
package ru.antivoland.anticode.tick {
import flash.events.Event;

public class TickEvent extends Event {
    public static const TICK:String = "tick";
    public static const SLOW_TICK:String = "slowTick";
    public static const FPS:String = "fps";

    private var dt:int = 0;

    public function TickEvent(type:String, dt:int) {
        super(type, false, false);
        this.dt = dt;
    }

    public function getDt():int {
        return dt;
    }
}
}
