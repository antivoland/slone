/**
 * @author antivoland
 */
package ru.antivoland.anticode.resize {
import flash.events.Event;

public class ResizeEvent extends Event {
    public static const STAGE_RESIZED:String = "stageResized";

    public function ResizeEvent() {
        super(STAGE_RESIZED, false, false);
    }
}
}
