/*
 * @author antivoland
 */
package ru.antivoland.anticode {
public class Callback {
    public static function invoke(callback:Function, success:Boolean, data:* = undefined):void {
        if (callback == null) {
            return;
        }
        callback.call(null, success, data);
    }
}
}