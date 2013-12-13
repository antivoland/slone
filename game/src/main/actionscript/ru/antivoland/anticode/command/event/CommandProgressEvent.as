/*
 * @author antivoland
 */
package ru.antivoland.anticode.command.event {
import flash.events.Event;

import ru.antivoland.anticode.command.Command;

public class CommandProgressEvent extends Event {
    public static const PROGRESS_CHANGED:String = "progressChanged";

    private var command:Command;

    public function CommandProgressEvent(command:Command) {
        super(PROGRESS_CHANGED, false, false);
        this.command = command;
    }

    public function getCommand():Command {
        return command;
    }
}
}