/**
 * @author antivoland
 */
package ru.antimiaou.slone.game {
final public class RunMode {
    public static const LOCAL:RunMode = new RunMode("local");
    public static const TEST:RunMode = new RunMode("test");
    public static const PUBLIC:RunMode = new RunMode("public");

    private var name:String;

    public function RunMode(name:String) {
        this.name = name;
    }
}
}
