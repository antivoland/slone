/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset.handler {
import flash.display.Bitmap;
import flash.display.Loader;

import ru.antivoland.anticode.asset.AssetType;
import ru.antivoland.anticode.asset.DynamicAsset;
import ru.antivoland.anticode.asset.command.ImageLoadCommand;
import ru.antivoland.anticode.command.Command;

public class ImageRequestHandler extends AbstractRequestHandler {
    override protected function createLoadCommand(type:AssetType, url:String):Command {
        return new ImageLoadCommand(url);
    }

    override protected function createInstance(asset:DynamicAsset):* {
        var loader:Loader = Loader(getData());
        if (loader.contentLoaderInfo.childAllowsParent) {
            return new Bitmap((loader.content as Bitmap).bitmapData.clone());
        } else {
            return getData();
        }
    }
}
}
