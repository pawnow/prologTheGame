prompt_conversation :-
	position(hero, Location),
	npc_position(NPC, Location),
	game_in_progress,
	state(NPC, 1, 0).

prompt_conversation :-
	position(hero, Location),
	\+ npc_position(_, Location),
	println("There is no one around...").
	
state(grandma, 1, 0) :-
	\+ active_quest(spiderman),
	\+ spider_gone,
	println("What do you want to know?"),
	println("0 - Just passing by."),
	println("1 - You look troubled. Is something wrong?"),
	println("2 - What can you tell me about the forest?"),
	println("3 - Why are you living in such a remote place?"), 
	read(Response),
	state(grandma, Response, 1).

state(grandma, 2, 1) :-
	println("It's really old... and full of dangerous creatures. You'd better tread carefully, or else you'll fall prey to their vicious instincts."),
	println("Rumors about the dragon living in this forest are true. Indeed, even if beasts of the forest don't make you tremble, you must not face the dragon."),
	println("Plenty of herbs, both common and rare, can be found in the woods, so if you are bold enough to trespass, then I guess you might as well look around and collect."),
	println("0 - I'll keep that in mind. Farewell."),	
	println("1 - Interesting. Let me ask about somehting else."),
	read(Response),
	state(grandma, Response, 0).
	
state(grandma, 3, 1) :-
	println("My life was a long and uneasy struggle. The more difficult it was, the more I longed for peace."),
	println("And so, I ended up here, in an old dark forest, surrounded by beasts. Still better than it used to be though."),
	println("0 - I'm about to make sure it no longer is."),	
	println("1 - It might be. There are other things I want to know."),
	read(Response),
	state(grandma, Response, 0).
	
state(grandma, 1, 0) :-
	active_quest(spiderman),
	\+ spider_gone,
	println("Is spider gone yet? Return when your quest is done!"), 
	state(grandma, 0, 1).
	
state(grandma, 1, 0) :-
	active_quest(spiderman),
	\+ spider_gone,
	println("Come back when the spider is no more!"),
	state(grandma, 0, 1).

state(grandma, 1, 1) :-
	active_quest(spiderman),
	spider_gone,
	println("The spider is gone? That's great! Here is your reward! You can use this key to unlock a treasure chest!"),
	assertz(has(hero, key)),
	finish_quest(spiderman),
	start_quest(bounty_hunter),
	state(grandma, 0, 1).	
	
state(grandma, 1, 1) :-
	println("Yes, actually. There is a giant spider living in a forest nearby. It seems to be extremely dangerous."),
	println("I'm unable to sleep well knowing that it's lurking somewhere in the darkness. Could you do something about it?"),
	println("0 - I can't. You see, I'm in a great hurry. I'm actually leaving right now. Bye."),
	println("1 - I'll think about that. In the mean time, I want to ask about something else."),
	println("2 - Sure, I'll help you."),
	read(Response),
	state(grandma, Response, 2).
	
state(grandma, 1, 2) :-
	println("Please help me. You are the only one who can."),
	state(grandma, 1, 0).

		
state(grandma, 2, 2) :-
	start_quest(spiderman),
	println("Marvelous! come back when it is done!").
	state(grandma, 0, 2).
	
state(grandma, 0, _) :-
	println("Bye.").
	



state(drake, 1, 0) :-
	\+ active_quest(saving_dragon),
	println("Hold on! We don't need to fight!"),
	println("0. Silence! I shall end you!"),
	println("1. What do you mean?"),
	read(Response),
	state(drake, Response, 1).

state(drake, 1, 0) :-
	active_quest(saving_dragon),
	\+ has(hero, dragonroots),
	\+ has(hero, bloodmoss),
	println("Retrieve the herbs!"),
	state(drake, 0, 0).

state(drake, 1, 0) :-
	active_quest(saving_dragon),
	has(hero, dragonroots),
	has(hero, bloodmoss),
	retract(has(hero, dragonroots)),
	retract(has(hero, bloodmoss)),
	println("The herbs! Now I can become human again!"),
	finish_quest(saving_dragon),
	println("You saved the dragon, and - by extension - the world. All is good now."),
	retractall(event(fight_dragon, _)),
	retractall(game_in_progress).

state(drake, 1, 1) :-
	println("I haven't always been a dragon... I was a knight until an evil curse turned me into a beast."),
	state(drake, 1, 2).
	
state(drake, 1, 2) :-	
	println("I can sense that you are a kind person... would you help me return to my true form?"),
	println("0. I don't believe any of your lies. Now prepare yourself, beast!"),
	println("1. What do I need to do to help you?"),
	println("2. How did that happen?"),
	read(Response),
	state(drake, Response, 3).	

state(drake, 2, 3) :-
	println("I don't remember much of it. Curse affects my memory. What I do recall is a witch preaching about some sort of malicious diety... and its champion."),
	println("I have memories of my previous life. I won't let evil magic dull my senses any further."),
	println("0 - Oh my, that's convenient! Cut the crap and fight me already!"),
	println("1 - I see. What were you saying earlier?"),
	read(Response),
	state(drake, Response, 2).	
		
state(drake, 1, 3) :-
	println("I need bloodmoss and dragonroots to perform the reversal ritual. They can be found in the forest, however I cannot obtain them myself."),
	println("Return to me when you will acquire both!"),
	start_quest(saving_dragon),
	state(drake, 0, 0).
	
state(drake, 0, 0) :-
	println("bye").

state(drake, 0, _) :-
	println("Time to fight the dragon!"),
	assertz(dragon_quest_rejected),
	println("The dragon killed you. Sad but"),
	retractall(event(fight_dragon, _)),
	retractall(game_in_progress).
	