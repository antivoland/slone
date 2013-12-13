/**
 * @author antivoland
 */
package ru.antimiaou.slone.game {
import ru.antimiaou.slone.game.conf.Conf;
import ru.antivoland.anticode.json.ObjectMapper;
import ru.antivoland.anticode.resize.ResizeManager;
import ru.antivoland.anticode.tick.TickManager;

public class App {
    public static var runMode:RunMode;
    public static var mapper:ObjectMapper;
    public static var conf:Conf;
    public static var tickManager:TickManager;
    public static var resizeManager:ResizeManager;
}
}
