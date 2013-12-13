/**
 * @author antivoland
 */
package ru.antivoland.anticode.mouse {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

public class MouseTracker {
    private var stage:Stage;
    private var state:MouseState = MouseState.UP;
    private var target:MouseListener;
    private var dragDelta:int = 0;
    private var lastPos:Point;

    public function MouseTracker(stage:Stage, target:MouseListener, dragDelta:int) {
        this.stage = stage;
        this.target = target;
        this.dragDelta = dragDelta;
    }

    public function run():void {
        registerContentEventHandlers();
    }

    private function setState(value:MouseState):void {
        if (state == value) {
            return;
        }
        var oldState:MouseState = state;
        state = value;
        if (oldState == MouseState.DRAG) {
            target.handleDragStop();
        }
        switch (state) {
            case MouseState.DOWN:
                registerStageEventHandlers();
                break;
            case MouseState.UP:
                unregisterStageEventHandlers();
                break;
            case MouseState.DRAG:
                target.handleDragMove(updateLastPosition());
                break;
        }
    }

    public function destroy():void {
        unregisterContentEventHandlers();
        unregisterStageEventHandlers();
    }

    private function targetContent():DisplayObjectContainer {
        return target.getContent();
    }

    private function globalMousePos():Point {
        return new Point(stage.mouseX, stage.mouseY);
    }

    private function updateLastPosition():Point {
        var tmp:Point = globalMousePos();
        var pos:Point = tmp.subtract(lastPos);
        lastPos = tmp;
        return pos;
    }

    private function registerContentEventHandlers():void {
        targetContent().addEventListener(MouseEvent.ROLL_OVER, handleContentRollOver);
        targetContent().addEventListener(MouseEvent.ROLL_OUT, handleContentRollOut);
        targetContent().addEventListener(MouseEvent.MOUSE_DOWN, handleContentMouseDown);
    }

    private function unregisterContentEventHandlers():void {
        targetContent().removeEventListener(MouseEvent.ROLL_OVER, handleContentRollOver);
        targetContent().removeEventListener(MouseEvent.ROLL_OUT, handleContentRollOut);
        targetContent().removeEventListener(MouseEvent.MOUSE_DOWN, handleContentMouseDown);
    }

    private function handleContentRollOver(event:MouseEvent):void {
        if (state == MouseState.UP) {
            setState(MouseState.OVER);
        } else if (state == MouseState.OVER) {
            setState(MouseState.DOWN);
        }
    }

    private function handleContentRollOut(event:MouseEvent):void {
        if (state == MouseState.OVER) {
            setState(MouseState.UP);
        } else if (state == MouseState.DOWN) {
            setState(MouseState.OVER);
        }
    }

    private function handleContentMouseDown(event:MouseEvent):void {
        setState(MouseState.DOWN);
        lastPos = globalMousePos();
    }

    private function registerStageEventHandlers():void {
        stage.addEventListener(MouseEvent.MOUSE_UP, handleStageMouseUp);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, handleStageMouseMove);
        stage.addEventListener(Event.MOUSE_LEAVE, handleStageMouseLeave);
    }

    private function unregisterStageEventHandlers():void {
        stage.removeEventListener(MouseEvent.MOUSE_UP, handleStageMouseUp);
        stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleStageMouseMove);
        stage.removeEventListener(Event.MOUSE_LEAVE, handleStageMouseLeave);
    }


    private function handleStageMouseUp(event:MouseEvent):void {
        var mouseOver:Boolean = targetContent().contains(DisplayObject(event.target));
        if (state == MouseState.DRAG) {
            setState(mouseOver ? MouseState.OVER : MouseState.UP);
        } else {
            if (mouseOver) {
                target.handleMouseClick(event.target);
            }
            setState(MouseState.UP);
        }
    }

    private function handleStageMouseMove(event:MouseEvent):void {
        if (state == MouseState.DRAG) {
            target.handleDragMove(updateLastPosition());
        } else if (state == MouseState.DOWN) {
            if (Point.distance(lastPos, globalMousePos()) > dragDelta) {
                target.handleDragStart(event.target);
                setState(MouseState.DRAG);
            }
        }
    }

    private function handleStageMouseLeave(event:Event):void {
        setState(MouseState.UP);
    }
}
}
