/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset.handler {
import ru.antivoland.anticode.asset.AssetType;
import ru.antivoland.anticode.asset.DynamicAsset;
import ru.antivoland.anticode.command.scheduler.CommandScheduler;

public interface RequestHandler {
    function initialize(type:AssetType, url:String, maxAttempts:int, scheduler:CommandScheduler = undefined):void;
    function handle(asset:DynamicAsset, callback:Function):void;
}
}