/*
 * @author antivoland
 */
package ru.antivoland.anticode.collection {
import flash.errors.IllegalOperationError;
import flash.utils.flash_proxy;

use namespace flash_proxy;

public class AbstractList extends AbstractCollection implements List {
    override public final function add(element:*):Boolean {
        addAt(size(), element);
        return true;
    }

    override public final function remove(element:*):Boolean {
        var index:int = indexOf(element);
        if (index < 0) {
            return false;
        }
        removeAt(index);
        return true;
    }

    override public final function addAll(elements:Array):Boolean {
        addAllAt(size(), elements);
        return true;
    }

    // List

    public function indexOf(element:*):int {
        throw new IllegalOperationError("Abstract method indexOf() must be overridden in a subclass");
    }

    public function getAt(index:int):* {
        throw new IllegalOperationError("Abstract method getAt() must be overridden in a subclass");
    }

    public function setAt(index:int, element:*):Object {
        throw new IllegalOperationError("Abstract method setAt() must be overridden in a subclass");
    }

    public function addAt(index:int, element:*):void {
        throw new IllegalOperationError("Abstract method addAt() must be overridden in a subclass");
    }

    public function removeAt(index:int):* {
        throw new IllegalOperationError("Abstract method removeAt() must be overridden in a subclass");
    }

    public function addAllAt(index:int, elements:Array):Boolean {
        throw new IllegalOperationError("Abstract method addAllAt() must be overridden in a subclass");
    }

    // Iterator

    override final flash_proxy function getProperty(name:*):* {
        return getAt(int(name));
    }

    override final flash_proxy function nextNameIndex(index:int):int {
        return index < size() ? index + 1 : 0;
    }

    override final flash_proxy function nextName(index:int):String {
        return (index - 1).toString();
    }

    override final flash_proxy function nextValue(index:int):* {
        return getAt(index - 1);
    }
}
}