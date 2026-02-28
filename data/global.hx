import funkin.backend.system.framerate.Framerate;
import funkin.backend.system.framerate.FramerateCounter;
import openfl.text.TextFormat;
import lime.graphics.Image;

public var funny:FlxSprite = new FlxSprite(0, 0, Paths.image("game/lowfpsbozo"));

function postStateSwitch()
{
    Framerate.fpsCounter.fpsNum.visible = false;
    Framerate.fpsCounter.fpsLabel.visible = false;
    Framerate.memoryCounter.visible = false;

    Framerate.codenameBuildField.defaultTextFormat = new TextFormat(Paths.getFontName(Paths.font('comic.ttf')), 16, -1);
}

function update()
{
    Framerate.codenameBuildField.text = Framerate.fpsCounter.fpsNum.text + " FPS\nMemory:\n" +  Framerate.memoryCounter.memoryText.text;
    Framerate.codenameBuildField.y = Framerate.fpsCounter.fpsLabel.y;
}

function destroy()
{
    Framerate.fpsCounter.fpsNum.visible = true;
    Framerate.fpsCounter.fpsLabel.visible = true;
    Framerate.memoryCounter.visible = true;
    Framerate.codenameBuildField.y = 42;
    Framerate.codenameBuildField.defaultTextFormat = new TextFormat(Framerate.fontName, 12 , -1);
}