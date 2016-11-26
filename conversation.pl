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
	println("Grandma"),
	println("0 - exit."),
	println("1 - Tell me more about the quest."), 
	read(Response),
	state(grandma, Response, 1).

	
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
	println("I can grant you a quest to kill spiders!"),
	println("0 - exit."),
	println("1 - No, I don't want to do that."),
	println("2 - Sure, I'll help you."),
	read(Response),
	state(grandma, Response, 2).
	
state(grandma, 1, 1) :-
	println("Well, that's too bad. Be gone then. I will remain here, if you happen to reconsider"),
	state(grandma, 0, 1).

		
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
	println("I haven't always been a dragon... I was a knight untill an evil curse turned me into a beast"),
	println("I can sense that you are a kind person... would you help me return to my true form?"),
	println("0. I don't believe any of your lies. Now prepare yourself, beast!"),
	println("1. What do I need to do to help you?"),
	read(Response),
	state(drake, Response, 2).	

state(drake, 1, 2) :-
	println("I need bloodmoss and dragonroots to perform the reversal ritual. They can be found in the forest, however I cannot obtain them myself."),
	println("Return to me when you will acquire both!"),
	start_quest(saving_dragon),
	state(drake, 0, 0).
	
state(drake, 0, 0) :-
	println("bye").

state(drake, 0, _) :-
	println("Time to fight the dragon!"),
	assertz(dragon_quest_rejected),
	println("The dragon kills you. Sad but"),
	retractall(event(fight_dragon, _)),
	retractall(game_in_progress).
	