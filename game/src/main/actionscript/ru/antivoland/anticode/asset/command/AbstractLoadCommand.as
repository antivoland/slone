/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset.command {
import flash.errors.IllegalOperationError;

import ru.antivoland.anticode.command.AbstractCommand;

public class AbstractLoadCommand extends AbstractCommand {
    protected static const DEFAULT_WEIGHT:int = 1;

    protected var url:String;
    protected var callback:Function;

    public function AbstractLoadCommand(url:String, weight:int) {
        super(weight);
        this.url = url;
    }

    override protected final function doBusiness(callback:Function):void {
        this.callback = callback;
        load();
    }

    protected function load():void {
        throw new IllegalOperationError("Abstract method load() must be overridden in a subclass");
    }
}
}