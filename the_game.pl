 :- ['utils', 'locations', 'items', 'location_map', 'skills', 'characteristics', 'game_init', 'quests'].

reset_game :-
    retractall(game_in_progress),
    retractall(has(_, _)),
    retractall(health_points(_, _)),
    retractall(location(_, _, _)),
    retractall(achivement(_)),
    retractall(current_quest(_)),
    retractall(finished_quest(_)),
    retractall(position(_, _)).
    
restart :-
    reset_game,
    consult_local('game_init.pl'),
    choose_your_class,
    assertz(game_in_progress),
    assertz(achivement(start_game)),
    level_up,
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
command(open_chest, open_chest).
command(quests, quest_log).
command(look_around, describe_directions).
    
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
	println("show - describe the current location"),
	println("north - go north"),
	println("east - go east"),
	println("south - go south"),
	println("west - go west"),
	println("take - take an item in the current location"),
	println("talk - talk to a person in the current location"),
	println("stats - to show character statistics"),
	println("char - to show hero characteristics"),
	println("achiev - to show list of collected achivements"),
	println("quests - shows the list of quests"),
	try((
		has(hero, location_map),
		println("map - show the map of the area")
	)),
	try((
		position(hero, Location),
		is_visible(chest, Location),
		println("open_chest - open chest if you have proper key")
	)),
	nl.
	