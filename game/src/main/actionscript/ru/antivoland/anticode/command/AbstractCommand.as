/*
 * @author antivoland
 */
package ru.antivoland.anticode.command {
import flash.errors.IllegalOperationError;
import flash.events.EventDispatcher;

import ru.antivoland.anticode.command.event.CommandProgressEvent;
import ru.antivoland.anticode.command.event.CommandStatusEvent;
import ru.antivoland.anticode.Callback;

[Event(name="statusChanged", type="ru.antivoland.anticode.command.event.CommandStatusEvent")]
[Event(name="progressChanged", type="ru.antivoland.anticode.command.event.CommandProgressEvent")]
public class AbstractCommand extends EventDispatcher implements Command {
    private var status:CommandStatus = CommandStatus.UNDEFINED;
    private var weight:int = 0;
    private var progress:Number = 0.0;
    private var data:*;
    private var callback:Function;

    function AbstractCommand(weight:int) {
        this.weight = weight;
    }

    public final function getStatus():CommandStatus {
        return status;
    }

    private function setStatus(status:CommandStatus):void {
        if (this.status == status) {
            return;
        }
        var oldStatus:CommandStatus = this.status;
        this.status = status;
        switch (this.status) {
            case CommandStatus.EXECUTING:
                handleExecuting();
                break;
            case CommandStatus.EXECUTED:
                handleExecuted();
                break;
            case CommandStatus.ERROR:
                handleError();
                break;
        }
        dispatchEvent(new CommandStatusEvent(this, oldStatus, this.status));
    }

    public final function getWeight():int {
        return weight;
    }

    public final function getProgress():Number {
        return progress;
    }

    protected final function setProgress(progress:Number):void {
        if (this.progress == progress) {
            return;
        }
        this.progress = progress;
        dispatchEvent(new CommandProgressEvent(this));
    }

    public final function getData():* {
        return data;
    }

    public final function setData(data:*):void {
        this.data = data;
    }

    public final function execute(callback:Function = undefined):void {
        if (getStatus() == CommandStatus.UNDEFINED) {
            this.callback = callback;
            setStatus(CommandStatus.EXECUTING);
        } else {
            Callback.invoke(callback, false, "Command execute fail");
        }
    }

    protected function doBusiness(callback:Function):void {
        throw new IllegalOperationError("Abstract method doBusiness() must be overridden in a subclass");
    }

    private function handleExecuting():void {
        setProgress(0);
        doBusiness(function (success:Boolean, data:* = undefined):void {
            setData(data);
            setStatus(success ? CommandStatus.EXECUTED : CommandStatus.ERROR);
        });
    }

    private function handleExecuted():void {
        setProgress(1);
        Callback.invoke(callback, true, getData());
    }

    private function handleError():void {
        Callback.invoke(callback, false, getData());
    }
}
}