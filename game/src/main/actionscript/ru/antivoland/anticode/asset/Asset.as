/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset {
public class Asset {
    private var id:String;
    private var type:AssetType;
    private var definition:String;

    public function Asset(id:String, type:AssetType, definition:String = undefined) {
        this.id = id;
        this.type = type;
        this.definition = definition;
    }

    public function getId():String {
        return id;
    }

    public function getType():AssetType {
        return type;
    }

    public function getDefinition():String {
        return definition;
    }

    public function hasDefinition():Boolean {
        return definition != null && definition.length > 0;
    }
}
}
