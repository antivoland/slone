/*
 * @author antivoland
 */
package ru.antimiaou.slone.game {
import flash.display.Sprite;

import ru.antimiaou.slone.game.world.World;

public class Game extends Sprite {
    private var world:World;

    public function run():void {
        world = new World();
        addChild(world);
        world.initialize();
        world.play();
    }
}
}