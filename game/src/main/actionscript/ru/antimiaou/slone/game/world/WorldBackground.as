/**
 * @author antivoland
 */
package ru.antimiaou.slone.game.world {
import flash.display.Sprite;
import flash.geom.Rectangle;

public class WorldBackground extends Sprite {
    private static const FILL_COLOR:uint = 0x00AA00;

    private var world:World;

    public function WorldBackground(world:World) {
        this.world = world;
    }

    public function redraw():void {
        clear();
        draw();
    }

    private function draw():void {
        var bounds:Rectangle = world.getScreenBounds();
        var back:Sprite = new Sprite();
        back.graphics.beginFill(FILL_COLOR);
        back.graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
        back.graphics.endFill();
        addChild(back);
    }

    public function clear():void {
        graphics.clear();
        while (numChildren > 0) {
            removeChildAt(0);
        }
    }
}
}
