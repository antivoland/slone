/*
 * @author antivoland
 */
package ru.antivoland.anticode.collection {
public interface Collection {
    /**
     * Returns <tt>true</tt> if this collection contains no elements.
     *
     * @return <tt>true</tt> if this collection contains no elements
     */
    function isEmpty():Boolean;

    /**
     * Returns the number of elements in this collection.
     *
     * @return the number of elements in this collection
     */
    function size():int;

    /**
     * Returns <tt>true</tt> if this collection contains the specified element.
     *
     * @param element element whose presence in this collection is to be tested
     * @return <tt>true</tt> if this collection contains the specified element
     */
    function contains(element:*):Boolean;

    /**
     * Adds the specified element to this collection.
     *
     * @param element element whose presence in this collection is to be ensured
     * @return <tt>true</tt> if this collection changed as a result of the call
     */
    function add(element:*):Boolean;

    /**
     * Removes a single instance of the specified element from this collection.
     *
     * @param element element to be removed from this collection
     * @return <tt>true</tt> if an element was removed as a result of this call
     */
    function remove(element:*):Boolean;

    /**
     * Adds all of the elements in the specified array to this collection.
     *
     * @param elements array containing elements to be added to this collection
     * @return <tt>true</tt> if this collection changed as a result of the call
     */
    function addAll(elements:Array):Boolean;

    /**
     * Removes all of the elements from this collection.
     */
    function clear():void;

    /**
     * Returns an array containing all of the elements in this collection.
     *
     * @return an array containing all of the elements in this collection
     */
    function toArray():Array;
}
}