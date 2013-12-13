/*
 * @author antivoland
 */
package ru.antivoland.anticode.command.scheduler.behaviour {
import flash.utils.getTimer;
import flash.utils.setTimeout;

import ru.antivoland.anticode.command.scheduler.CommandSchedulerImpl;

public class DelayedSchedulerBehaviour extends AbstractSchedulerBehaviour {
    private var executeDelayMillis:Number = 0;
    private var lastExecuteMillis:Number = 0;

    public function DelayedSchedulerBehaviour(scheduler:CommandSchedulerImpl, executeDelayMillis:Number) {
        super(scheduler);
        this.executeDelayMillis = executeDelayMillis;
    }

    override public function next():void {
        var sinceLastExecutedMillis:Number = getTimer() - lastExecuteMillis;
        if (sinceLastExecutedMillis < executeDelayMillis) {
            setTimeout(next, executeDelayMillis - sinceLastExecutedMillis);
            return;
        }
        lastExecuteMillis = getTimer();
        scheduler.next();
    }
}
}