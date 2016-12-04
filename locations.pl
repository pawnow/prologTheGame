:- dynamic describe/1.

:- ['items'].

go(XDelta, YDelta) :-
    position(hero, Location),
    location(Location, X, Y),
    X1 is X + XDelta,
    Y1 is Y + YDelta,
    location(NewLocation, X1, Y1),
    retract(position(hero, Location)),
    assert(position(hero, NewLocation)),
    describe_location, !.

go(_, _) :-
    println('That is nothing interesting there, choose other direction.').

go_north :- go(0, 1).
go_south :- go(0, -1).
go_east :- go(1, 0).
go_west :- go(-1, 0).
    
describe_location :-
	position(hero, Location),
	describe_location(Location),
	describe_items(Location).

describe_location(meadow) :-
	println("You see a cave in the west and a hill in the north.").
        
describe_location(cave) :-
	println("You enter the cave, there is dark inside."),
	try((
		is_visible(chest, cave),
		println("You use your torchlight and see chest on the ground, write 'open.' to try opening it.")
	)).
        
describe_location(dragon_cave) :-
    println("You see a dragon inside lying in the cave."),
    try((
        is_alive(dragon),
        not(is_enemy(dragon)),
        println("Speak to it to wake it up.")
    )).
    
describe_location(hill) :-
    println("You climb up a hill and look around."),
    println("You can see a lake and a boat wreck in the far north.").
    
describe_location(forest_entry) :-
    println("You're on the edge of an old forest.").
    
describe_location(forest(F)) :-
    println("You're inside an old forest."),
    try((
	   position(spider, forest(F)),
	   \+ spider_gone,
	   println("You can see a somewhat big spider in the glade. It did not notice you yet.")
	)).
    
describe_location(forest_hut) :-
	println("You're standing in front of a small forest hut. There is an old lady inside.").
	
describe_location(canyon(_)) :-
    println("You're at the bottom of a deep canyon.").
    
describe_location(lake) :-
	println("There's water all around").
	
describe_location(beach) :-
	println("You're on a beach. Some remnants of an old boat are standing out of the water.").
	
describe_location(desert(D)) :-
	println("Sand under your feet, sand in your eyes, sand all around"),
	try((
	   position(snake(S), desert(D)),
	   is_alive(snake(S)),
	   println("There's a wild snake. It seems aggressive.")
	)).
	
describe_items(Location) :-
	position(Item, Location),
	is_item(Item),
	write("There is "), describe_item(Item),
	println("Write 'take.' to take this item.").

describe_items(_).

describe_directions :-
	position(hero, Location),
	location(Location, X, Y),
	XWest is X - 1,
    XEast is X + 1,
    YNorth is Y + 1,
    YSouth is Y - 1,
    describe_direction('west', XWest, Y),
    describe_direction('east', XEast, Y),
    describe_direction('north', X, YNorth),
    describe_direction('south', X, YSouth).

describe_direction(Direction, X, Y) :-
    location(Place, X, Y),
    location_name(Place, PlaceName),
    write('You can go '), write(Direction),
    write(' to find '),
    write(PlaceName),
    write('.'), nl.
    
describe_direction(_, _, _) :-
    write('').
	
location_name(meadow, "meadow").
location_name(cave, "cave").
location_name(dragon_cave, "mountain").
location_name(hill, "hill").
location_name(forest_entry, "forest").
location_name(forest(_), "forest").
location_name(forest_hut, "forest hut").
location_name(canyon(_), "canyon").
location_name(beach, "beach").
location_name(lake, "lake").
location_name(desert(_), "desert").

