/*
 * @author antivoland
 */
package ru.antivoland.anticode.command {
import flash.events.IEventDispatcher;

import ru.antivoland.anticode.DataBindable;

[Event(name="statusChanged", type="ru.antivoland.anticode.command.event.CommandStatusEvent")]
[Event(name="progressChanged", type="ru.antivoland.anticode.command.event.CommandProgressEvent")]
public interface Command extends DataBindable, IEventDispatcher {
    function getStatus():CommandStatus;
    function getWeight():int;
    function getProgress():Number;
    function execute(callback:Function = undefined):void;
}
}