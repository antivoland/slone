/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset.handler {
import ru.antivoland.anticode.asset.AssetType;
import ru.antivoland.anticode.asset.DynamicAsset;
import ru.antivoland.anticode.command.scheduler.CommandScheduler;
import ru.antivoland.anticode.Callback;

public class BlankRequestHandler implements RequestHandler {
    public function initialize(type:AssetType, url:String, maxAttempts:int, scheduler:CommandScheduler = undefined):void {
        // do nothing
    }

    public function handle(asset:DynamicAsset, callback:Function):void {
        Callback.invoke(callback, false, "Wrong definition for asset " + asset.getId());
    }
}
}
