/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset.handler {
import ru.antivoland.anticode.asset.DynamicAsset;

public class XmlRequestHandler extends DataRequestHandler {
    override protected function createInstance(asset:DynamicAsset):* {
        return XML(super.createInstance(asset));
    }
}
}