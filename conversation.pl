prompt_conversation :-
	position(hero, Location),
	npc_position(NPC, Location),
	game_in_progress,
	state(NPC, 1, 0).

prompt_conversation :-
	position(hero, Location),
	\+ npc_position(_, Location),
	write("There is no one around..."), nl.

	
state(npc_1, 1, 0) :-
	write("Howdy m8"), nl,
	state(npc_1, 2, 0).
		
state(npc_1, 2, 0) :-
	write("What do you want to know?"), nl,
	write("0 - exit."), nl,
	write("1 - option 1?"), nl,
	write("2 - option 2?"), nl,
	read(Response),
	state(npc_1, Response, 2).
		
state(npc_1, 0, _) :-
	write("Bye."), nl.

state(npc_1, 1, 2) :-
	write("response for option 1."), nl,
	state(npc_1, 2, 0).
	
state(npc_1, 2, 2) :-
	write("response for option 2"), nl,
	write("0 - exit."), nl,
	write("1 - go back to initial options."), nl,
	write("2 - go further."), nl,
	read(Response),
	state(npc_1, Response, 4).

state(npc_1, 1, 4) :-
	state(npc_1, 2, 0).
	
state(npc_1, 2, 4) :-
	write("Additional response."), nl,
	state(npc_1, 2, 0).