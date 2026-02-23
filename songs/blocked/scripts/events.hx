import SubtitleManager;

function stepHit(curStep)
{
    switch (curStep)
	{
		case 128:
			defaultCamZoom += 0.1;
			FlxG.camera.flash(FlxColor.WHITE, 0.5);
			black = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
			black.screenCenter();
			black.alpha = 0;
			add(black);
			FlxTween.tween(black, {alpha: 0.6}, 1);
			makeInvisibleNotes(true);
			SubtitleManager.addSubtitle(SubtitleManager.getTextString('blocked_sub1'), 0.02, 1);
		case 165:
			SubtitleManager.addSubtitle(SubtitleManager.getTextString('blocked_sub2'), 0.02, 1);
		case 188:
		    SubtitleManager.addSubtitle(SubtitleManager.getTextString('blocked_sub3'), 0.02, 1);
		case 224:
			SubtitleManager.addSubtitle(SubtitleManager.getTextString('blocked_sub4'), 0.02, 1);
		case 248:
			SubtitleManager.addSubtitle(SubtitleManager.getTextString('blocked_sub5'), 0.02, 0.5, 60);
		case 256:
			defaultCamZoom -= 0.1;
			FlxG.camera.flash();
			FlxTween.tween(black, {alpha: 0}, 1);
			makeInvisibleNotes(false);
		case 640:
			FlxG.camera.flash();
			black.alpha = 0.6;
			defaultCamZoom += 0.1;
		case 768:
			FlxG.camera.flash();
			defaultCamZoom -= 0.1;
			black.alpha = 0;
		case 1028:
			makeInvisibleNotes(true);
			SubtitleManager.addSubtitle(SubtitleManager.getTextString('blocked_sub6'), 0.02, 1.5);
		case 1056:
			SubtitleManager.addSubtitle(SubtitleManager.getTextString('blocked_sub7'), 0.02, 1);
		case 1084:
			SubtitleManager.addSubtitle(SubtitleManager.getTextString('blocked_sub8'), 0.02, 1);
		case 1104:
			SubtitleManager.addSubtitle(SubtitleManager.getTextString('blocked_sub9'), 0.02, 1);
		case 1118:
			SubtitleManager.addSubtitle(SubtitleManager.getTextString('blocked_sub10'), 0.02, 1);
		case 1143:
			SubtitleManager.addSubtitle(SubtitleManager.getTextString('blocked_sub11'), 0.02, 1, 45);
			makeInvisibleNotes(false);
		case 1152:
			FlxTween.tween(black, {alpha: 0.4}, 1);
			defaultCamZoom += 0.3;
		case 1200:
			camHUD.addShader(blockedGlitchEffect);
			camNotes.addShader(blockedGlitchEffect);
	    	FlxTween.tween(black, {alpha: 0.7}, (Conductor.stepCrochet / 1000) * 8);
		case 1216:
	    	FlxG.camera.flash(FlxColor.WHITE, 0.5);
			camHUD.removeShader(blockedGlitchEffect);
			camNotes.removeShader(blockedGlitchEffect);
			remove(black);
	    	defaultCamZoom -= 0.3;
	}
}