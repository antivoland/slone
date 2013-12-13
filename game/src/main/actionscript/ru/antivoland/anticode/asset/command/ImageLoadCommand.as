/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset.command {
import flash.display.Loader;
import flash.events.AsyncErrorEvent;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLRequest;
import flash.system.LoaderContext;

import ru.antivoland.anticode.Callback;

public class ImageLoadCommand extends AbstractLoadCommand {
    private var loader:Loader = new Loader();

    public function ImageLoadCommand(url:String, weight:int = DEFAULT_WEIGHT) {
        super(url, weight);
    }

    override protected function load():void {
        registerLoadHandlers();
        var request:URLRequest = new URLRequest(url);
        var context:LoaderContext = new LoaderContext(true);
        loader.load(request, context);
    }

    private function registerLoadHandlers():void {
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoaded);
        loader.contentLoaderInfo.addEventListener(AsyncErrorEvent.ASYNC_ERROR, handleLoadFail);
        loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleLoadFail);
        loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleLoadFail);
    }

    private function unregisterLoadHandlers():void {
        loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, handleLoaded);
        loader.contentLoaderInfo.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, handleLoadFail);
        loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, handleLoadFail);
        loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleLoadFail);
    }

    private function handleLoaded(event:Event):void {
        unregisterLoadHandlers();
        Callback.invoke(callback, true, loader);
    }

    private function handleLoadFail(event:ErrorEvent):void {
        unregisterLoadHandlers();
        Callback.invoke(callback, false, event.text);
    }
}
}