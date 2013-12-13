/*
 * @author antivoland
 */
package ru.antivoland.anticode.collection {
import flash.events.IEventDispatcher;

[Event(name="elementAdded", type="ru.antivoland.anticode.collection.CollectionEvent")]
[Event(name="elementRemoved", type="ru.antivoland.anticode.collection.CollectionEvent")]
[Event(name="elementReplaced", type="ru.antivoland.anticode.collection.CollectionEvent")]
[Event(name="subsequenceAdded", type="ru.antivoland.anticode.collection.CollectionEvent")]
[Event(name="cleared", type="ru.antivoland.anticode.collection.CollectionEvent")]
public interface List extends Collection, IEventDispatcher {
    /**
     * Returns the index of the first occurrence of the specified element
     * in this list, or -1 if this list does not contain the element.
     *
     * @param element element to search for
     * @return the index of the first occurrence of the specified element
     *         in this list, or -1 if this list does not contain the element
     */
    function indexOf(element:*):int;

    /**
     * Returns the element at the specified position in this list.
     *
     * @param index index of the element to return
     * @return the element at the specified position in this list
     */
    function getAt(index:int):*;

    /**
     * Replaces the element at the specified position in this list with
     * the specified element.
     *
     * @param index index of the element to replace
     * @param element element to be stored at the specified position
     * @return the element previously at the specified position
     */
    function setAt(index:int, element:*):Object;

    /**
     * Inserts the specified element at the specified position in this list.
     * Shifts the element currently at that position and any subsequent
     * elements to the right (adds one to their indices).
     *
     * @param index index at which the specified element is to be inserted
     * @param element element to be inserted
     */
    function addAt(index:int, element:*):void;

    /**
     * Removes the element at the specified position in this list. Shifts any
     * subsequent elements to the left (subtracts one from their indices).
     *
     * @param index the index of the element to be removed
     * @return the element that was removed from the list
     */
    function removeAt(index:int):*;

    /**
     * Inserts all of the elements in the specified array into this list
     * at the specified position. Shifts the element currently at that position
     * and any subsequent elements to the right (increases their indices).

     * @param index index at which the specified array is to be inserted
     * @param elements array containing elements to be added to this list
     * @return <tt>true</tt> if this list changed as a result of the call
     */
    function addAllAt(index:int, elements:Array):Boolean;
}
}