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
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;
import flash.system.Security;
import flash.system.SecurityDomain;

import ru.antivoland.anticode.Callback;

public class MediaLoadCommand extends AbstractLoadCommand {
    private var library:Boolean = false;
    private var loader:Loader = new Loader();

    public function MediaLoadCommand(url:String, library:Boolean, weight:int = DEFAULT_WEIGHT) {
        super(url, weight);
        this.library = library;
    }

    override protected function load():void {
        registerLoadHandlers();
        var request:URLRequest = new URLRequest(url);
        var context:LoaderContext = createLoaderContext();
        loader.load(request, context);
    }

    private function createLoaderContext():LoaderContext {
        var context:LoaderContext;
        if (Security.sandboxType == Security.REMOTE) {
            context = new LoaderContext(false, null, SecurityDomain.currentDomain);
        } else {
            context = new LoaderContext(false);
        }
        if (library) {
            context.applicationDomain = ApplicationDomain.currentDomain;
        }
        return context;
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