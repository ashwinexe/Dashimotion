library

digression fuck_off
{
    conditions { on #messageHasAnyIntent(digression.fuck_off.triggers); }
    var triggers = ["fuck_off"];
    var responses: Phrases[] = ["fuck_off"];
    do
    {
        for (var item in digression.fuck_off.responses)
        {
            #say(item, repeatMode: "ignore");
        }
        //#repeat(accuracy: "short");
        return;
    }
    transitions
    {
    }
}