/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset.handler {
import ru.antivoland.anticode.asset.AssetType;
import ru.antivoland.anticode.asset.DynamicAsset;
import ru.antivoland.anticode.asset.command.DataLoadCommand;
import ru.antivoland.anticode.command.Command;

public class DataRequestHandler extends AbstractRequestHandler {
    override protected function createLoadCommand(type:AssetType, url:String):Command {
        return new DataLoadCommand(url);
    }

    override protected function createInstance(asset:DynamicAsset):* {
        return getData();
    }
}
}
