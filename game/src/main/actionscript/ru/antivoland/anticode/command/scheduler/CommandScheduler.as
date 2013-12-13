/*
 * @author antivoland
 */
package ru.antivoland.anticode.command.scheduler {
import ru.antivoland.anticode.command.Command;

public interface CommandScheduler {
    function execute(command:Command, callback:Function = undefined):void;
}
}