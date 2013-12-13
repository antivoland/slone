/*
 * @author antivoland
 */
package ru.antivoland.anticode.collection {
import flash.errors.IllegalOperationError;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.utils.Proxy;

public class AbstractCollection extends Proxy implements Collection, IEventDispatcher {
    private var dispatcher:EventDispatcher = new EventDispatcher();

    // Collection

    public final function isEmpty():Boolean {
        return size() == 0;
    }

    public function size():int {
        throw new IllegalOperationError("Abstract method size() must be overridden in a subclass");
    }

    public function contains(element:*):Boolean {
        throw new IllegalOperationError("Abstract method contains() must be overridden in a subclass");
    }

    public function add(element:*):Boolean {
        throw new IllegalOperationError("Abstract method add() must be overridden in a subclass");
    }

    public function remove(element:*):Boolean {
        throw new IllegalOperationError("Abstract method remove() must be overridden in a subclass");
    }

    public function addAll(elements:Array):Boolean {
        throw new IllegalOperationError("Abstract method addAll() must be overridden in a subclass");
    }

    public function clear():void {
        throw new IllegalOperationError("Abstract method clear() must be overridden in a subclass");
    }

    public function toArray():Array {
        throw new IllegalOperationError("Abstract method toArray() must be overridden in a subclass");
    }

    // IEventDispatcher

    public final function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
        dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }

    public final function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
        dispatcher.removeEventListener(type, listener, useCapture);
    }

    public final function dispatchEvent(event:Event):Boolean {
        return dispatcher.dispatchEvent(event);
    }

    public final function hasEventListener(type:String):Boolean {
        return dispatcher.hasEventListener(type);
    }

    public final function willTrigger(type:String):Boolean {
        return dispatcher.willTrigger(type);
    }
}
}