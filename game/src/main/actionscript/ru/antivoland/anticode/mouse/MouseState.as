/**
 * @author antivoland
 */
package ru.antivoland.anticode.mouse {
internal class MouseState {
    public static const DOWN:MouseState = new MouseState("DOWN");
    public static const OVER:MouseState = new MouseState("OVER");
    public static const UP:MouseState = new MouseState("UP");
    public static const DRAG:MouseState = new MouseState("DRAG");

    private var name:String;

    public function MouseState(name:String) {
        this.name = name;
    }
}
}
