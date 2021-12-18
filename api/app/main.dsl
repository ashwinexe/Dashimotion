import "commonReactions/all.dsl";

context {
    // declare input variables here. endpoint must always be declared. name is optional 
    input endpoint: string;
    input name: string = ""; 

    // declare storage variables here 
    someVariable: string = "";
}

// declare external functions here 
external function someExternalFunction(log: string): string;

start node root {
    do { 
        // connecting to the endpoint which is specified in index.js that it can also be in-terminal text chat
        #connectSafe($endpoint);

        // give the person a second to start speaking 
        #waitForSpeech(1000); 

        // and greet them. Refer to phrasemap.json > "greeting" (line 12); 
        // note the variable $name for phraseFmap use
        #say("greeting", { name: $name });
        wait *;
    }

    // specifies to which nodes the conversation goes from here 
    transitions {
        // feel free to modify your own intents for "yes" and "no" in data.json
        yes: goto yes on #messageHasIntent("yes");
        no: goto no on #messageHasIntent("no"); 
    }
}

node yes {
    do {
        // call your external function
        var result = external someExternalFunction("test");

        // call on phrase "question_1" from the phrasemap
        #say("yes");

        // call exit to end the conversation
        exit;
    }
}

node no {
    do {
        #say("no");
        exit;
    }
}

digression how_are_you {
    conditions {
        on #messageHasIntent("how_are_you");
    }

    do {
        #sayText("I'm well, thank you!", repeatMode: "ignore"); 

        // let the app know to repeat the phrase in the node from which the digression was called, when go back to the node
        #repeat();

        // go back to the node from which we got distracted into the digression
        return; 
    }
}
