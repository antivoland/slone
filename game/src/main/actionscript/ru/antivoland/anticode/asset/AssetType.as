/*
 * @author antivoland
 */
package ru.antivoland.anticode.asset {
import ru.antivoland.anticode.asset.handler.BlankRequestHandler;
import ru.antivoland.anticode.asset.handler.DataRequestHandler;
import ru.antivoland.anticode.asset.handler.ImageRequestHandler;
import ru.antivoland.anticode.asset.handler.JsonRequestHandler;
import ru.antivoland.anticode.asset.handler.MediaRequestHandler;
import ru.antivoland.anticode.asset.handler.SoundRequestHandler;
import ru.antivoland.anticode.asset.handler.XmlRequestHandler;

public class AssetType {
    public static const BINARY:AssetType = new AssetType("binary", DataRequestHandler, ["dat", "bin", ""]);
    public static const TEXT:AssetType = new AssetType("text", DataRequestHandler, ["txt", "log"]);
    public static const JSON:AssetType = new AssetType("json", JsonRequestHandler, ["json"]);
    public static const XML:AssetType = new AssetType("xml", XmlRequestHandler, ["xml"]);
    public static const CSS:AssetType = new AssetType("css", DataRequestHandler, ["css"]);
    public static const SWF:AssetType = new AssetType("swf", MediaRequestHandler, ["swf"]);
    public static const LIBRARY:AssetType = new AssetType("library", MediaRequestHandler, []);
    public static const IMAGE:AssetType = new AssetType("image", ImageRequestHandler, ["jpg", "jpeg", "png", "gif"]);
    public static const SOUND:AssetType = new AssetType("sound", SoundRequestHandler, ["mp3", "wav"]);
    public static const UNKNOWN:AssetType = new AssetType("unknown", BlankRequestHandler, []);

    private static var typesByName:Object;
    private static var typesByExtension:Object;

    private var name:String;
    private var clazz:Class;

    public function AssetType(name:String, clazz:Class, extensions:Array) {
        this.name = name;
        this.clazz = clazz;
        registerType(this);
        registerExtensions(this, extensions);
    }

    public function getName():String {
        return name;
    }

    public function getClazz():Class {
        return clazz;
    }

    public function toString():String {
        return name;
    }

    public static function findByName(name:String):AssetType {
        return typesByName[name] || UNKNOWN;
    }

    public static function findByExtension(extension:String):AssetType {
        return typesByExtension[extension] || UNKNOWN;
    }

    public static function findByUrl(url:String):AssetType {
        return findByExtension(getFileExtension(url));
    }

    private static function registerType(type:AssetType):void {
        if (typesByName == null) {
            typesByName = {};
        }
        typesByName[type.getName()] = type;
    }

    private static function registerExtensions(type:AssetType, extensions:Array):void {
        if (typesByExtension == null) {
            typesByExtension = {};
        }
        for each (var extension:String in extensions) {
            typesByExtension[extension] = type;
        }
    }

    private static function getFileExtension(url:String):String {
        var end:int = url.indexOf("?");
        if (end < 0) {
            end = url.length;
        }
        var start:int = url.lastIndexOf(".", end);
        if (start <= url.lastIndexOf("/", end)) {
            return "";
        }
        return url.substring(start + 1, end);
    }
}
}
