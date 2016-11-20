 :- ['utils', 'locations', 'items', 'location_map', 'conversation'].

reset_game :-
    retractall(game_in_progress),
    retractall(has(_, _)),
    retractall(health_points(_, _)),
    retractall(location(_, _, _)),
    retractall(position(_, _)).
    
restart :-
    reset_game,
    consult_local('game_init.pl'),
    assertz(game_in_progress),
    display_help,
    handle_events,
    continue.
    
continue :-
	describe_location,
    prompt_command.
    
prompt_command :-
    game_in_progress,
    prompt1("> "),
    read(Command), nl,
    perform_command(Command),
    handle_events,
    prompt_command.
    
prompt_command.


command(help, display_help).
%command(where, describe_directions).    
command(show, describe_location).
command(east, go_east).
command(west, go_west).
command(north, go_north).
command(south, go_south).
command(take, take).
command(items, describe_inventory).
command(map, show_map).
command(talk, prompt_conversation).
perform_command(quit) :-
	retractall(game_in_progress).

perform_command(Command) :-
    command(Command, Action),
    (call(Action); true).
    
perform_command(Command) :-
    write("Cannot perform action '"), write(Command), write("'"), nl,
    prompt_command.
    
    
handle_events :-
	findall(event(Name, Scenario), event(Name, Scenario), Events),
	handle_events(Events).
    
handle_events(Events) :-
	foreach(member(event(_, Scenario), Events), try(Scenario)),
	findall(event(Name, Scenario), event(Name, Scenario), NewEvents),
	(
		Events \= NewEvents
	->
		handle_events(NewEvents)
	;
		true
	).
    
display_help :-
	write("Type a command followed by a period to perform an action."), nl,
	write("help - show this instruction"), nl,
	write("quit - quit the game"), nl,
	write("show - describe the current location"), nl,
	write("north - go north"), nl,
	write("east - go east"), nl,
	write("south - go south"), nl,
	write("west - go west"), nl,
	write("take - take an item in the current location"), nl,
	write("talk - talk to a person in the current location"), nl,
	try((
		has(hero, location_map),
		write("map - show the map of the area"), nl
	)),
	nl.
	