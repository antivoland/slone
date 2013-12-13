/*
 * @author antivoland
 */
package ru.antivoland.anticode.collection {
import flash.events.Event;

public class CollectionEvent extends Event {
    public static const ELEMENT_ADDED:String = "elementAdded";
    public static const ELEMENT_REMOVED:String = "elementRemoved";
    public static const ELEMENT_REPLACED:String = "elementReplaced";
    public static const SUBSEQUENCE_ADDED:String = "subsequenceAdded";
    public static const CLEARED:String = "cleared";

    private var index:int;
    private var length:int;

    public function getIndex():int {
        return index;
    }

    public function getLength():int {
        return length;
    }

    public function CollectionEvent(type:String, index:int = -1, length:int = -1) {
        super(type, false, false);
        this.index = index;
        this.length = length;
    }
}
}