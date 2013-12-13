/**
 * @author antivoland
 */
package ru.antimiaou.slone.game {
import com.junkbyte.console.Cc;
import com.junkbyte.console.ConsoleChannel;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.ui.ContextMenu;

import ru.antimiaou.slone.game.conf.Conf;
import ru.antivoland.anticode.Callback;
import ru.antivoland.anticode.command.CommandQueue;
import ru.antivoland.anticode.command.FunctionCommand;
import ru.antivoland.anticode.json.ObjectMapper;
import ru.antivoland.anticode.resize.ResizeManager;
import ru.antivoland.anticode.tick.TickManager;

[SWF(backgroundColor="#000000", frameRate="30", width="800", height="600")]
public class Main extends Sprite {
    private static const log:ConsoleChannel = new ConsoleChannel("Main");

    public function Main():void {
        if (stage != null) {
            initialize();
        } else {
            addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
        }

        function handleAddedToStage(event:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
            initialize();
        }
    }

    protected function initialize():void {
        setupConsole();
        setupStage();
        setupContextMenu();

        App.runMode = RunMode.LOCAL; // TODO: fix
        App.mapper = new ObjectMapper();
        App.tickManager = new TickManager(stage);
        App.resizeManager = new ResizeManager(stage);

        var commands:Array = [];
        commands.push(new FunctionCommand(loadConf));

        var queue:CommandQueue = new CommandQueue(commands, 0);
        queue.execute(function (success:Boolean, data:* = undefined):void {
            if (success) {
                log.info("Initialize complete");
                var game:Game = new Game();
                addChild(game);
                game.run();
            } else {
                log.error(data);
            }
        });
    }

    private function setupConsole():void {
        Cc.startOnStage(this, "`");
        Cc.config.commandLineAllowed = true;
        Cc.config.tracing = true;
        Cc.config.maxLines = 2000;

        Cc.addMenu("hi", Cc.log, ["Hello from top menu"], "Says hello!");

        // Slash command example 1
        Cc.addSlashCommand("test", function ():void {
            Cc.log("Do the test!");
        });
        //When user type "/test" in commandLine, it will call function with no params.

        // Slash command example 2
        Cc.addSlashCommand("test2", function (param:String = ""):void {
            Cc.log("Do the test2 with param string:", param);
        });
        //User type "/test2 abc 123" in commandLine to call Cc.log with one param: "abc 123".

    }

    private function setupStage():void {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.stageFocusRect = false;
        stage.tabChildren = false;
    }

    private function setupContextMenu():void {
        var menu:ContextMenu = new ContextMenu();
        menu.builtInItems.loop = false;
        menu.builtInItems.forwardAndBack = false;
        menu.builtInItems.play = false;
        menu.builtInItems.print = false;
        menu.builtInItems.rewind = false;
        menu.builtInItems.save = false;
        menu.builtInItems.zoom = false;
        contextMenu = menu;
    }

    private function loadConf(callback:Function):void {
        var conf:Conf = new Conf();
        conf.load(function (success:Boolean, data:* = undefined):void {
            if (success) {
                App.conf = conf;
                log.info("Configuration loaded");
            }
            Callback.invoke(callback, success, data);
        });
    }
}
}
