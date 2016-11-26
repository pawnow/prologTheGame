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
	
	
	