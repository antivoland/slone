/*
 * @author antivoland
 */
package ru.antimiaou.slone.game.world {
import flash.display.Sprite;

public class WorldLocation extends Sprite {
    private var world:World;

    public function WorldLocation(world:World) {
        this.world = world;

        /*
         _content = new Sprite();
         _content.mouseEnabled = false;
         _trackerLayer.addChild(_content);

         _dropOverlay = new Sprite();
         _dropOverlay.mouseEnabled = false;
         addChild(_dropOverlay);

         _bubbleOverlay = new Sprite();
         _bubbleOverlay.mouseEnabled = false;
         _bubbleOverlay.mouseChildren = false;
         addChild(_bubbleOverlay);

         _foreground = new Sprite();
         _foreground.mouseEnabled = false;
         _foreground.mouseChildren = false;
         addChild(_foreground);

         _guiOverlay = new Sprite();
         _guiOverlay.mouseEnabled = false;
         addChild(_guiOverlay);

         _positionAnimator.initialize(this);

         ResizeManager.registerResizeListener(this);
         */
    }
}
}