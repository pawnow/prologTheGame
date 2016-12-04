:- ['utils', 'locations', 'items', 'location_map', 'skills', 'characteristics', 'quests', 'conversation', 'combat'].

reset_world :-
    retractall(has(_, _)),
    retractall(health_points(_, _)),
    retractall(location(_, _, _)),
    retractall(active_quest(_)),
    retractall(finished_quest(_)),
    retractall(position(_, _)),
    retractall(chosen_hero_class(_)),
    retractall(level(_)),
    retractall(trained_stat(_, _)),
    retractall(is_enemy(_)).
    
initialize_world :-
	consult_local('game_init.pl').
    
new_game :-
	retractall(achievement(_)),
	retractall(visited(_)),
	assertz(game_in_progress),
    add_achievement("Start the game."),
	replay.
	
replay :-
    reset_world,
    initialize_world,
    choose_your_class,
    level_up,
    display_help,
    handle_events,
    continue.
    
continue :-
	assertz(game_in_progress),
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
command(die, commit_suicide). 
command(show, describe_location).
command(east, go_east).
command(west, go_west).
command(north, go_north).
command(south, go_south).
command(take, take).
command(items, describe_inventory).
command(map, show_map).
command(stats, print_current_stats).
command(char, print_characteristics).
command(achiev, print_collected_achievements).
command(open, open_chest).
command(quests, quest_log).
command(look, describe_directions).
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
	println("Type a command followed by a period to perform an action."),
	println("help - show this instruction"),
	println("quit - quit the game"),
	println("die - commit a suicide to start the game once again"),
	println("show - describe the current location"),
	println("north - go north"),
	println("east - go east"),
	println("south - go south"),
	println("west - go west"),
	println("take - take an item in the current location"),
	println("talk - talk to a person in the current location"),
	println("stats - show character statistics"),
	println("char - show hero characteristics"),
	println("achiev - show list of collected achivements"),
	println("quests - show the list of quests"),
	println("look - check where hero can move"),
	try((
		has(hero, location_map),
		println("map - show the map of the area")
	)),
	try((
		position(hero, Location),
		is_visible(chest, Location),
		println("open - open chest if you have proper key")
	)),
	nl.
	
commit_suicide :-
	add_achievement("Commit a suicide."),
	replay.
	