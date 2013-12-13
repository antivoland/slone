/*
 * @author antivoland
 */
package ru.antivoland.anticode.command {
public class CommandStatus {
    public static const UNDEFINED:CommandStatus = new CommandStatus("UNDEFINED");
    public static const EXECUTING:CommandStatus = new CommandStatus("EXECUTING");
    public static const EXECUTED:CommandStatus = new CommandStatus("EXECUTED");
    public static const ERROR:CommandStatus = new CommandStatus("ERROR");

    private var name:String;

    public function CommandStatus(name:String) {
        this.name = name;
    }

    public function toString():String {
        return name;
    }
}
}