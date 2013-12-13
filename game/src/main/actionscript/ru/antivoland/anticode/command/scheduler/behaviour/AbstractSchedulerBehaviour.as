/*
 * @author antivoland
 */
package ru.antivoland.anticode.command.scheduler.behaviour {
import flash.errors.IllegalOperationError;

import ru.antivoland.anticode.command.scheduler.CommandSchedulerImpl;

public class AbstractSchedulerBehaviour {
    protected var scheduler:CommandSchedulerImpl;

    public function AbstractSchedulerBehaviour(scheduler:CommandSchedulerImpl) {
        this.scheduler = scheduler;
    }

    public function next():void {
        throw new IllegalOperationError("Abstract method next() must be overridden in a subclass");
    }
}
}