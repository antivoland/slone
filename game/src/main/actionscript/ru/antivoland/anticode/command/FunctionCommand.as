/*
 * @author antivoland
 */
package ru.antivoland.anticode.command {
[Event(name="statusChanged", type="ru.antivoland.anticode.command.event.CommandStatusEvent")]
[Event(name="progressChanged", type="ru.antivoland.anticode.command.event.CommandProgressEvent")]
public class FunctionCommand extends AbstractCommand {
    private static const WEIGHT:int = 1;

    private var targetHandler:Function;
    private var args:Array;

    public function FunctionCommand(targetHandler:Function, ...args) {
        super(WEIGHT);
        this.targetHandler = targetHandler;
        this.args = args;
    }

    override protected final function doBusiness(callback:Function):void {
        targetHandler.apply(null, args.concat(callback));
    }
}
}