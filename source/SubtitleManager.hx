import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;

class SubtitleManager
{
	static var currentList = CoolUtil.coolTextFile(Paths.file('texts/textList.txt'));
	
	public static function getTextString(stringName:String)
	{
    	var returnedString:String = '';
    	for (i in 0...currentList.length)
    	{
    	    var currentValue = currentList[i].split('==');
    	    // currentValue = currentValue.split('==');
    	    if (currentValue[0] != stringName)
    	    {
    	        continue;
    	    }
    	    else
    	    {
     	       returnedString = currentValue[1];
     	    }
    	}

    	if (returnedString == '')
    	{
    	    return stringName;
    	}
    	else
    	{
    	    returnedString = StringTools.replace(returnedString, ':linebreak:', '\n');
    		returnedString = StringTools.replace(returnedString, ':addquote:', '\"');
     	   return returnedString;
    	}
	}

    public static function addSubtitle(text:String, typeSpeed:Float, delayss:Float, ?subtitleSize:Float = 30)
    {
        var sub:FlxTypeText = new FlxTypeText(0, 0, FlxG.width, text, 30);
        sub.setFormat(Paths.font("comic.ttf"), subtitleSize, 0xFFFFFF, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, 0xFF000000);
        if (subtitleSize == null)
        {
            sub.size = 30;
        }
        sub.antialiasing = true;
        sub.borderSize = 1.5;
        sub.cameras = [PlayState.instance.camHUD];
        sub.start(typeSpeed, false, false, [], () -> {
            new FlxTimer().start(1, () -> {
                FlxTween.tween(sub, {alpha: 0}, 0.5, {onComplete: () -> {
                    sub.destroy();
                }});
            });
        });
        sub.screenCenter(FlxAxes.X);
        sub.y = (FlxG.height / 2) - 200;
        PlayState.instance.add(sub);
    }
}