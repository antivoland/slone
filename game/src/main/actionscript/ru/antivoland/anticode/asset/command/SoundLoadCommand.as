/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset.command {
import flash.events.AsyncErrorEvent;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.media.Sound;
import flash.net.URLRequest;

import ru.antivoland.anticode.Callback;

public class SoundLoadCommand extends AbstractLoadCommand {
    private var sound:Sound = new Sound();

    public function SoundLoadCommand(url:String, weight:int = DEFAULT_WEIGHT) {
        super(url, weight);
    }

    override protected function load():void {
        registerLoadHandlers();
        var request:URLRequest = new URLRequest(url);
        sound.load(request);
    }

    private function registerLoadHandlers():void {
        sound.addEventListener(Event.COMPLETE, handleLoaded);
        sound.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleLoadFail);
        sound.addEventListener(AsyncErrorEvent.ASYNC_ERROR, handleLoadFail);
        sound.addEventListener(IOErrorEvent.IO_ERROR, handleLoadFail);
    }

    private function unregisterLoadHandlers():void {
        sound.removeEventListener(Event.COMPLETE, handleLoaded);
        sound.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleLoadFail);
        sound.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, handleLoadFail);
        sound.removeEventListener(IOErrorEvent.IO_ERROR, handleLoadFail);
    }

    private function handleLoaded(event:Event):void {
        unregisterLoadHandlers();
        Callback.invoke(callback, true, sound);
    }

    private function handleLoadFail(event:ErrorEvent):void {
        unregisterLoadHandlers();
        Callback.invoke(callback, false, event.text);
    }
}
}