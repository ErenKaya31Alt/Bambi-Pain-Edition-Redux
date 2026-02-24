import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.ui.FlxBarFillDirection;
import MoreCoolUtil;
import SubtitleManager;

public var camNotes:HudCamera = new HudCamera();
public var blockedGlitchEffect:CustomShader = new CustomShader("BlockedGlitchEffect");
public var elapsedtime:Float = 0.00;
public var isOldVariant:Bool;

var timeBarBG:FunkinSprite = new FunkinSprite(0, 0, Paths.image("game/timeBar"));
var timeBar:FlxBar;

var black:FlxSprite;

var songNameTxt:FunkinText = new FunkinText(4, 0, FlxG.width, "chud", 16);
var timeTxt:FunkinText = new FunkinText(0, 0, FlxG.width, "0:00", 20);
var newScoreTxt:FunkinText;

function postCreate()
{
    FlxG.cameras.insert(camNotes, 1, false).bgColor = FlxColor.TRANSPARENT;
    camNotes.downscroll = Options.downscroll;
    strumLines.members[0].camera = strumLines.members[1].camera = camNotes;

    isOldVariant = checkForVariant();

    var yPos = Options.downscroll ? FlxG.height * 0.9 + 20 : strumLine.y - 20;

    newScoreTxt = new FunkinText(healthBarBG.x + healthBarBG.width / 2 - 150, healthBarBG.y + 40, FlxG.width, "AW SHUCKS", 20);
    newScoreTxt.setFormat(Paths.font("comic.ttf"), 20, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    newScoreTxt.scrollFactor.set();
	newScoreTxt.borderSize = 1.5;
	newScoreTxt.antialiasing = true;
    newScoreTxt.camera = camHUD;
	newScoreTxt.screenCenter(FlxAxes.X);
	add(newScoreTxt);

    newScoreTxt.text = SubtitleManager.getTextString('play_score') + Std.string(songScore) + " | " + SubtitleManager.getTextString('play_miss') + misses +  " | " + SubtitleManager.getTextString('play_accuracy') + "0%";

    add(songNameTxt).camera = camHUD;
    songNameTxt.text = SONG.meta.displayName;
    songNameTxt.font = Paths.font("comic.ttf");
    songNameTxt.borderSize = 1.25;
    songNameTxt.y = FlxG.height - songNameTxt.height;

    add(timeBarBG).camera = camHUD;
    timeBarBG.y = yPos;
    timeBarBG.antialiasing = Options.antialiasing;
    timeBarBG.screenCenter(FlxAxes.X);
    timeBarBG.scrollFactor.set();

    timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxBarFillDirection.LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), inst, 'time', 0, inst.length);
    timeBar.scrollFactor.set();
    timeBar.camera = camHUD;
    timeBar.createFilledBar(FlxColor.GRAY, FlxColor.fromRGB(57, 255, 20));
    insert(members.indexOf(timeBarBG), timeBar);

    add(timeTxt).camera = camHUD;
    timeTxt.setFormat(Paths.font("comic.ttf"), 32, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    timeTxt.setPosition(0, timeBarBG.y);
    timeTxt.screenCenter(FlxAxes.X);
    timeTxt.borderSize = 2.5;
    timeTxt.antialiasing = Options.antialiasing;

	var yValues = MoreCoolUtil.getMinAndMax(timeTxt.height, timeBarBG.height);
	timeTxt.y = timeBarBG.y + ((yValues[0] - yValues[1]) / 2);

    remove(healthBarBG);
    remove(healthBar);
    add(healthBar);
    add(healthBarBG);

    for (i in [scoreTxt, missesTxt, accuracyTxt])
    {
        remove(i);
    }
}

function update(elapsed:Float) {
    elapsedtime += elapsed;

    if (inst != null && timeBar != null && timeBar.max != inst.length) {
        timeBar.setRange(0, Math.max(1, inst.length));
    }

    if (inst != null && timeTxt != null) {
        var timeRemaining = Std.int((inst.length - Conductor.songPosition) / 1000);
        var seconds = CoolUtil.addZeros(Std.string(timeRemaining % 60), 2);
        var minutes = Std.int(timeRemaining / 60);
        timeTxt.text = minutes + ":" + seconds;
    }

    blockedGlitchEffect.time = elapsedtime;

    camNotes.zoomMultiplier = camHUD.zoomMultiplier;
    camNotes.zoom = camHUD.zoom;
}

function onPlayerHit()
{
    newScoreTxt.text = SubtitleManager.getTextString('play_score') + Std.string(songScore) + " | " + SubtitleManager.getTextString('play_miss') + misses +  " | " + SubtitleManager.getTextString('play_accuracy') + truncateFloat((accuracy * 100), 2) + "%";
}

function onPlayerMiss()
{
    newScoreTxt.text = SubtitleManager.getTextString('play_score') + Std.string(songScore) + " | " + SubtitleManager.getTextString('play_miss') + misses +  " | " + SubtitleManager.getTextString('play_accuracy') + truncateFloat((accuracy * 100), 2) + "%";
}

public function truncateFloat(number:Float, precision:Int):Float
{
	var num = number;
	num = num * Math.pow(10, precision);
	num = Math.round(num) / Math.pow(10, precision);
	return num;
}

public function makeInvisibleNotes(invisible:Bool)
{
	if (invisible)
	{
		FlxTween.cancelTweensOf(camNotes);
		FlxTween.tween(camNotes, {alpha: 0}, 1);
	}
	else
	{
		FlxTween.cancelTweensOf(camNotes);
		FlxTween.tween(camNotes, {alpha: 1}, 1);
	}
}

public function checkForVariant()
{
    if (PlayState.variation.toLowerCase() == 'old')
    {
        return true;
    } else {
        return false;
    }
}