/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset.handler {
import flash.display.Loader;
import flash.system.ApplicationDomain;

import ru.antivoland.anticode.asset.AssetType;
import ru.antivoland.anticode.asset.DynamicAsset;
import ru.antivoland.anticode.asset.command.MediaLoadCommand;
import ru.antivoland.anticode.command.Command;

public class MediaRequestHandler extends AbstractRequestHandler {
    override protected function createLoadCommand(type:AssetType, url:String):Command {
        return new MediaLoadCommand(url, type == AssetType.LIBRARY);
    }

    override protected function createInstance(asset:DynamicAsset):* {
        if (!asset.hasDefinition()) {
            return getData();
        }

        var loader:Loader = Loader(getData());
        var domain:ApplicationDomain = loader.contentLoaderInfo.applicationDomain || ApplicationDomain.currentDomain;
        var clazz:Class;
        if (domain.hasDefinition(asset.getDefinition())) {
            clazz = domain.getDefinition(asset.getDefinition()) as Class;
        } else {
            return null;
        }
        return clazz != null ? new clazz() : null;
    }
}
}
