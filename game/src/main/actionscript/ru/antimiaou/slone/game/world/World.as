/*
 * @author antivoland
 */
package ru.antimiaou.slone.game.world {
import flash.display.Sprite;
import flash.geom.Rectangle;

import ru.antimiaou.slone.game.App;
import ru.antivoland.anticode.resize.ResizeEvent;

public class World extends Sprite {
    private var screenBounds:Rectangle = new Rectangle(0, 0, 0, 0);
    private var tracker:WorldTracker;
    private var background:WorldBackground;
    private var location:WorldLocation;

    public function getScreenBounds():Rectangle {
        return screenBounds;
    }

    public function initialize():void {
        screenBounds = App.resizeManager.getBaseBounds().clone();

        tracker = new WorldTracker(this);
        addChild(tracker);
        tracker.mouseEnabled = false;

        background = new WorldBackground(this);
        tracker.addChild(background);
        background.mouseEnabled = true;
        background.redraw();

        App.resizeManager.addEventListener(ResizeEvent.STAGE_RESIZED, handleStageResized);

        mouseChildren = true;
    }

    public function play():void {
        tracker.start();
    }

    private function handleStageResized(event:ResizeEvent):void {
        background.redraw();
    }
}
}