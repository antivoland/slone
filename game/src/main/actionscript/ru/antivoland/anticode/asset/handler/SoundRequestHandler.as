/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset.handler {
import ru.antivoland.anticode.asset.AssetType;
import ru.antivoland.anticode.asset.DynamicAsset;
import ru.antivoland.anticode.asset.command.SoundLoadCommand;
import ru.antivoland.anticode.command.Command;

public class SoundRequestHandler extends AbstractRequestHandler {
    override protected function getMaxAttempts():int {
        return 1;
    }

    override protected function createLoadCommand(type:AssetType, url:String):Command {
        return new SoundLoadCommand(url);
    }

    override protected function createInstance(asset:DynamicAsset):* {
        return getData();
    }
}
}