/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset.command {
import flash.events.AsyncErrorEvent;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

import ru.antivoland.anticode.Callback;

public class DataLoadCommand extends AbstractLoadCommand {
    private var loader:URLLoader = new URLLoader();

    public function DataLoadCommand(url:String, weight:int = DEFAULT_WEIGHT) {
        super(url, weight);
    }

    override protected function load():void {
        registerLoadHandlers();
        var request:URLRequest = new URLRequest(url);
        loader.load(request);
    }

    private function registerLoadHandlers():void {
        loader.addEventListener(Event.COMPLETE, handleLoaded);
        loader.addEventListener(AsyncErrorEvent.ASYNC_ERROR, handleLoadFail);
        loader.addEventListener(IOErrorEvent.IO_ERROR, handleLoadFail);
        loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleLoadFail);
    }

    private function unregisterLoadHandlers():void {
        loader.removeEventListener(Event.COMPLETE, handleLoaded);
        loader.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, handleLoadFail);
        loader.removeEventListener(IOErrorEvent.IO_ERROR, handleLoadFail);
        loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleLoadFail);
    }

    private function handleLoaded(event:Event):void {
        unregisterLoadHandlers();
        Callback.invoke(callback, true, loader.data);
    }

    private function handleLoadFail(event:ErrorEvent):void {
        unregisterLoadHandlers();
        Callback.invoke(callback, false, event.text);
    }
}
}