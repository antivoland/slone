/**
 * @author antivoland
 */
package ru.antimiaou.slone.game.conf {
import com.junkbyte.console.Cc;
import com.junkbyte.console.ConsoleChannel;

import ru.antimiaou.slone.game.App;

import ru.antimiaou.slone.game.conf.entity.*;
import ru.antivoland.anticode.Callback;
import ru.antivoland.anticode.asset.command.DataLoadCommand;
import ru.antivoland.anticode.command.Command;
import ru.antivoland.anticode.command.CommandQueue;
import ru.antivoland.anticode.command.FunctionCommand;

public class Conf {
    private static const log:ConsoleChannel = new ConsoleChannel("Conf");

    public var locations:Vector.<Location>;
    public var dialogs:Vector.<Dialog>;

    public function load(callback:Function):void {
        var commands:Array = [];
        commands.push(new FunctionCommand(loadLocations));
        commands.push(new FunctionCommand(loadDialogs));

        var queue:CommandQueue = new CommandQueue(commands, 0);
        queue.execute(callback);
    }

    private function loadLocations(callback:Function):void {
        var command:Command = new DataLoadCommand("conf/locations.json");
        command.execute(function (success:Boolean, data:* = undefined):void {
            if (success) {
                locations = App.mapper.readObject(Vector.<Location> as Class, JSON.parse(data)) as Vector.<Location>;
                log.info("Locations loaded");
            }
            Callback.invoke(callback, success, data);
        });
    }

    private function loadDialogs(callback:Function):void {
        var command:Command = new DataLoadCommand("conf/dialogs.json");
        command.execute(function (success:Boolean, data:* = undefined):void {
            if (success) {
                dialogs = App.mapper.readObject(Vector.<Dialog> as Class, JSON.parse(data)) as Vector.<Dialog>;
                log.info("Dialogs loaded");
            }
            Callback.invoke(callback, success, data);
        });
    }
}
}
