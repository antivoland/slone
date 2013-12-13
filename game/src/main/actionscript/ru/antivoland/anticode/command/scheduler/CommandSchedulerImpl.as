/*
 * @author antivoland
 */
package ru.antivoland.anticode.command.scheduler {
import ru.antivoland.anticode.command.Command;
import ru.antivoland.anticode.command.scheduler.behaviour.AbstractSchedulerBehaviour;
import ru.antivoland.anticode.command.scheduler.behaviour.DelayedSchedulerBehaviour;
import ru.antivoland.anticode.command.scheduler.behaviour.SimpleSchedulerBehaviour;
import ru.antivoland.anticode.Callback;

public class CommandSchedulerImpl {
    private var behaviour:AbstractSchedulerBehaviour;
    private var current:Command;
    [ArrayElementType("ru.antivoland.anticode.command.Command")]
    private var commands:Array = [];
    [ArrayElementType("Function")]
    private var callbacks:Array = [];

    public function CommandSchedulerImpl(executeDelayMillis:Number = 0) {
        if (executeDelayMillis > 0) {
            this.behaviour = new DelayedSchedulerBehaviour(this, executeDelayMillis);
        } else {
            this.behaviour = new SimpleSchedulerBehaviour(this);
        }
    }

    public final function execute(command:Command, callback:Function = undefined):void {
        commands.push(command);
        callbacks.push(callback);
        behaviour.next();
    }

    public function next():void {
        if (current != null || commands.length == 0) {
            return;
        }
        current = commands.shift();
        current.execute(function (success:Boolean, data:* = undefined):void {
            Callback.invoke(callbacks.shift(), success, data);
            current = null;
            behaviour.next();
        });
    }
}
}