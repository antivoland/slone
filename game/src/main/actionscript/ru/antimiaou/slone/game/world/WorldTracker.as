/**
 * @author antivoland
 */
package ru.antimiaou.slone.game.world {
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.geom.Point;

import mx.logging.ILogger;
import mx.logging.Log;

import ru.antivoland.anticode.mouse.MouseListener;
import ru.antivoland.anticode.mouse.MouseTracker;

public class WorldTracker extends Sprite implements MouseListener {
    private static const log:ILogger = Log.getLogger("ru.antimiaou.slone.game.world.WorldTracker");

    private static const DRAG_DELTA:int = 5;

    private var world:World;
    private var tracker:MouseTracker;

    public function WorldTracker(world:World) {
        this.world = world;
    }

    public function start():void {
        tracker = new MouseTracker(world.stage, this, DRAG_DELTA);
        tracker.run();
    }

    public function stop():void {
        if (tracker != null) {
            tracker.destroy();
        }
    }

    public function getContent():DisplayObjectContainer {
        return this;
    }

    public function handleMouseClick(target:Object):void {
        log.debug("Handle mouse click");
    }

    public function handleDragStart(target:Object):void {
        log.debug("Handle drag start");
    }

    public function handleDragMove(delta:Point):void {
        log.debug("Handle drag move");
    }

    public function handleDragStop():void {
        log.debug("Handle drag stop");
    }
}
}
