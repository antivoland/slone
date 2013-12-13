/*
 * @author antivoland
 */
package ru.antivoland.anticode.command {
import flash.utils.setTimeout;

import ru.antivoland.anticode.command.event.CommandProgressEvent;
import ru.antivoland.anticode.Callback;

[Event(name="statusChanged", type="ru.antivoland.anticode.command.event.CommandStatusEvent")]
[Event(name="progressChanged", type="ru.antivoland.anticode.command.event.CommandProgressEvent")]
public class CommandQueue extends AbstractCommand {
    [ArrayElementType("ru.antivoland.anticode.command.Command")]
    private var commands:Array = [];
    private var executeDelayMillis:Number = 0;

    public function CommandQueue(commands:Array, executeDelayMillis:Number) {
        for each (var command:Command in commands) {
            this.commands.push(command);
        }
        super(remainingWeight());
        this.executeDelayMillis = executeDelayMillis;
    }

    override protected function doBusiness(callback:Function):void {
        next(callback);
    }

    private function next(callback:Function):void {
        if (commands.length == 0) {
            Callback.invoke(callback, true);
            return;
        }

        var command:Command = commands.shift();
        command.addEventListener(CommandProgressEvent.PROGRESS_CHANGED, handleCommandProgressChanged);
        command.execute(function (success:Boolean, data:* = undefined):void {
            command.removeEventListener(CommandProgressEvent.PROGRESS_CHANGED, handleCommandProgressChanged);
            if (success) {
                if (executeDelayMillis > 0) {
                    setTimeout(next, executeDelayMillis, callback);
                } else {
                    next(callback);
                }
            } else {
                Callback.invoke(callback, false, data);
            }
        });
    }

    private function remainingWeight():int {
        var remainingWeight:int = 0;
        for each (var command:Command in commands) {
            remainingWeight += command.getWeight();
        }
        return remainingWeight;
    }

    private function handleCommandProgressChanged(event:CommandProgressEvent):void {
        var command:Command = event.getCommand();
        var remainingCommandWeight:Number = (1.0 - command.getProgress()) * command.getWeight();
        setProgress(1 - (remainingCommandWeight + remainingWeight()) / getWeight());
    }
}
}