/**
 * @author antivoland
 */
package ru.antivoland.anticode.resize {
import flash.display.Stage;
import flash.display.StageDisplayState;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.geom.Rectangle;

[Event(name="stageResized", type="ru.antivoland.anticode.resize.ResizeEvent")]
public class ResizeManager extends EventDispatcher {
    private var stage:Stage;
    private var baseBounds:Rectangle;

    public function ResizeManager(stage:Stage) {
        this.stage = stage;
        this.baseBounds = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);

        stage.addEventListener(Event.RESIZE, handleStageResize);
        stage.addEventListener(Event.FULLSCREEN, handleStageResize);
    }

    public function getStageWidth():int {
        return stage.stageWidth;
    }

    public function getStageHeight():int {
        return stage.stageHeight;
    }

    public function getBaseBounds():Rectangle {
        return baseBounds;
    }

    public function isFullscreen():Boolean {
        return stage.displayState == StageDisplayState.FULL_SCREEN;
    }

    public function setFullscreen(fullscreen:Boolean):void {
        stage.displayState = fullscreen ? StageDisplayState.FULL_SCREEN : StageDisplayState.NORMAL;
    }

    private function handleStageResize(event:Event):void {
        dispatchEvent(new ResizeEvent());
    }
}
}
