/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset {
public class DynamicAsset extends Asset {
    private var url:String;
    private var lazy:Boolean = false;

    public function DynamicAsset(id:String, type:AssetType, url:String, definition:String = undefined) {
        super(id, type, definition);
        this.url = url;
    }

    public function getUrl():String {
        return url;
    }

    public function setUrl(url:String):void {
        this.url = url;
    }

    public function isLazy():Boolean {
        return lazy;
    }

    public function setLazy(lazy:Boolean):void {
        this.lazy = lazy;
    }
}
}
