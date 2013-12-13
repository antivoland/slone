/*
 * @author antivoland
 */
package ru.antivoland.anticode.command.scheduler.behaviour {
import ru.antivoland.anticode.command.scheduler.CommandSchedulerImpl;

public class SimpleSchedulerBehaviour extends AbstractSchedulerBehaviour {
    public function SimpleSchedulerBehaviour(scheduler:CommandSchedulerImpl) {
        super(scheduler);
    }

    override public function next():void {
        scheduler.next();
    }
}
}