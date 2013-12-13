/**
 * @author antivoland
 */
package ru.antivoland.anticode.mouse {
import flash.display.DisplayObjectContainer;
import flash.geom.Point;

public interface MouseListener {
    function getContent():DisplayObjectContainer;
    function handleMouseClick(target:Object):void;
    function handleDragStart(target:Object):void;
    function handleDragMove(delta:Point):void;
    function handleDragStop():void;
}
}
