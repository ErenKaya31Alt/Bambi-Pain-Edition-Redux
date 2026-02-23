function onDadHit(event) {
    if (event.noteType == "phone") {
        event.preventAnim();

        if (dad.curCharacter == "bambi")
        {
            dad.playAnim("singSmash", true);
        } else {
            dad.playAnim("hey", true);
        }
    }
}

function onPlayerHit(event) {
    if (event.noteType == "phone") {
        event.preventAnim();

        if (bf.curCharacter == "bf" && dad.curCharacter == "bambi")
        {
            dad.playAnim("singThrow", true);
            bf.playAnim("dodge", true);
        } else if (bf.curCharacter != "bf" && dad.curCharacter == "bambi")  {
            dad.playAnim("singThrow", true);
            bf.playAnim("hey", true);
        }
    }
}