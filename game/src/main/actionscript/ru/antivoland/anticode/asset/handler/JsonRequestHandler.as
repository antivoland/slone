/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset.handler {
import ru.antivoland.anticode.asset.DynamicAsset;

public class JsonRequestHandler extends DataRequestHandler {
    override protected function createInstance(asset:DynamicAsset):* {
        return JSON.parse(super.createInstance(asset));
    }
}
}
