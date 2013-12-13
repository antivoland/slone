/*
 * @author antivoland
 */
package ru.antivoland.anticode.command.event {
import flash.events.Event;

import ru.antivoland.anticode.command.CommandStatus;
import ru.antivoland.anticode.command.Command;

public class CommandStatusEvent extends Event {
    public static const STATUS_CHANGED:String = "statusChanged";

    private var command:Command;
    private var oldStatus:CommandStatus;
    private var newStatus:CommandStatus;

    public function CommandStatusEvent(command:Command, oldStatus:CommandStatus, newStatus:CommandStatus) {
        super(STATUS_CHANGED, false, false);
        this.command = command;
        this.oldStatus = oldStatus;
        this.newStatus = newStatus;
    }

    public function getCommand():Command {
        return command;
    }

    public function getOldStatus():CommandStatus {
        return oldStatus;
    }

    public function getNewStatus():CommandStatus {
        return newStatus;
    }
}
}