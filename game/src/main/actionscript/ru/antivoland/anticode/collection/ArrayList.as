/*
 * @author antivoland
 */
package ru.antivoland.anticode.collection {
[Event(name="elementAdded", type="ru.antivoland.anticode.collection.CollectionEvent")]
[Event(name="elementRemoved", type="ru.antivoland.anticode.collection.CollectionEvent")]
[Event(name="elementReplaced", type="ru.antivoland.anticode.collection.CollectionEvent")]
[Event(name="subsequenceAdded", type="ru.antivoland.anticode.collection.CollectionEvent")]
[Event(name="cleared", type="ru.antivoland.anticode.collection.CollectionEvent")]
public class ArrayList extends AbstractList {
    private var data:Array = [];

    public function ArrayList(elements:Array = undefined) {
        if (elements != null) {
            addAllElementsAt(0, elements, true);
        }
    }

    override public final function size():int {
        return data.length;
    }

    override public final function contains(element:*):Boolean {
        return data.indexOf(element) >= 0;
    }

    override public final function clear():void {
        removeAllElements(false);
    }

    override public final function toArray():Array {
        var elements:Array = [];
        for each (var element:* in data) {
            elements.push(element);
        }
        return elements;
    }

    // ...

    override public final function indexOf(element:*):int {
        return data.indexOf(element);
    }

    override public final function getAt(index:int):* {
        return data[index];
    }

    override public final function setAt(index:int, element:*):Object {
        return setElementAt(index, element, false);
    }

    override public final function addAt(index:int, element:*):void {
        addElementAt(index, element, false);
    }

    override public final function removeAt(index:int):* {
        return removeElementAt(index, false);
    }

    override public final function addAllAt(index:int, elements:Array):Boolean {
        addAllElementsAt(index, elements, false);
        return true;
    }

    // ...

    protected final function setElementAt(index:int, element:*, silent:Boolean):* {
        var previous:* = data[index];
        data[index] = element;
        if (!silent) {
            dispatchEvent(new CollectionEvent(CollectionEvent.ELEMENT_REPLACED, index));
        }
        return previous;
    }

    protected final function addElementAt(index:int, element:*, silent:Boolean):void {
        if (index < data.length) {
            data.splice(index, 0, element);
        } else {
            data.push(element);
        }
        if (!silent) {
            dispatchEvent(new CollectionEvent(CollectionEvent.ELEMENT_ADDED, index));
        }
    }

    protected final function removeElementAt(index:int, silent:Boolean):* {
        var element:* = data.splice(index, 1)[0];
        if (!silent) {
            dispatchEvent(new CollectionEvent(CollectionEvent.ELEMENT_REMOVED, index));
        }
        return element;
    }

    protected final function addAllElementsAt(index:int, elements:Array, silent:Boolean):void {
        for (var i:int = 0, l:int = elements.length; i < l; ++i) {
            addElementAt(index + i, elements[i], true);
        }
        if (!silent) {
            dispatchEvent(new CollectionEvent(CollectionEvent.SUBSEQUENCE_ADDED, index, elements.length));
        }
    }

    protected final function removeAllElements(silent:Boolean):void {
        data.splice(0, data.length);
        if (!silent) {
            dispatchEvent(new CollectionEvent(CollectionEvent.CLEARED));
        }
    }
}
}