/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset.handler {
import flash.errors.IllegalOperationError;

import ru.antivoland.anticode.asset.AssetType;
import ru.antivoland.anticode.asset.DynamicAsset;
import ru.antivoland.anticode.command.Command;
import ru.antivoland.anticode.command.scheduler.CommandScheduler;
import ru.antivoland.anticode.Callback;

internal class AbstractRequestHandler implements RequestHandler {
    private var state:RequestState = RequestState.WAITING;
    private var command:Command;
    private var attempts:int = 0;
    private var scheduler:CommandScheduler;
    [ArrayElementType("ru.antivoland.anticode.asset.DynamicAsset")]
    private var assets:Array = [];
    [ArrayElementType("Function")]
    private var callbacks:Array = [];
    private var maxAttempts:int = 0;

    protected function getMaxAttempts():int {
        return maxAttempts;
    }

    protected function getData():* {
        return command.getData();
    }

    protected function createLoadCommand(type:AssetType, url:String):Command {
        throw new IllegalOperationError("Abstract method createLoadCommand() must be overridden in a subclass");
    }

    protected function createInstance(asset:DynamicAsset):* {
        throw new IllegalOperationError("Abstract method createInstance() must be overridden in a subclass");
    }

    public function initialize(type:AssetType, url:String, maxAttempts:int, scheduler:CommandScheduler = undefined):void {
        this.command = createLoadCommand(type, url);
        this.maxAttempts = maxAttempts;
        this.scheduler = scheduler;
    }

    public function handle(asset:DynamicAsset, callback:Function):void {
        switch (state) {
            case RequestState.WAITING:
                registerRequester(asset, callback);
                load();
                break;
            case RequestState.LOADING:
                registerRequester(asset, callback);
                break;
            case RequestState.READY:
                commitInstance(asset, callback);
                break;
            case RequestState.ERROR:
                if (attempts < getMaxAttempts()) {
                    registerRequester(asset, callback);
                } else {
                    Callback.invoke(callback, false, command.getData());
                }
                break;
        }
    }

    private function registerRequester(asset:DynamicAsset, callback:Function):void {
        assets.push(asset);
        callbacks.push(callback);
    }

    private function commitInstance(asset:DynamicAsset, callback:Function):void {
        var instance:*;
        try {
            instance = createInstance(asset);
        } catch (e:Error) {
            Callback.invoke(callback, false, "Unable to instantiate asset " + asset.getId());
            return;
        }

        if (instance != null) {
            Callback.invoke(callback, true, instance);
        } else {
            Callback.invoke(callback, false, "Missing asset " + asset.getId());
        }
    }

    private function load():void {
        state = RequestState.LOADING;
        if (scheduler != null) {
            scheduler.execute(command, handleLoaded);
        } else {
            command.execute(handleLoaded);
        }
    }

    private function handleLoaded(success:Boolean, data:* = undefined):void {
        ++attempts;
        if (success) {
            state = RequestState.READY;
            while (callbacks.length > 0) {
                commitInstance(assets.shift(), callbacks.shift());
            }
        } else {
            if (attempts < getMaxAttempts()) {
                load();
            } else {
                state = RequestState.ERROR;
                while (callbacks.length > 0) {
                    Callback.invoke(callbacks.shift(), false, data);
                }
                assets.splice(0, assets.length);
            }
        }
    }
}
}
