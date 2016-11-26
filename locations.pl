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
    println("You see a dragon inside the cave.").
    
describe_location(hill) :-
    println("You climb up a hill and look around.").
    
describe_location(forest_entry) :-
    println("You're on the edge of an old forest.").
    
describe_location(forest(_, _)) :-
    println("You're inside an old forest.").
    
describe_location(spider_forest) :-
    describe_location(forest(_, _)).
    
describe_location(forest_hut) :-
	println("You're standing in front of a small forest hut. There is an old lady inside.").
	
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
    describe_direction('West', XWest, Y),
    describe_direction('East', XEast, Y),
    describe_direction('North', X, YNorth),
    describe_direction('South', X, YSouth).

describe_direction(Direction, X, Y) :-
    location(Place, X, Y),
    location_name(Place, PlaceName),
    write('You can go '), write(Direction),
    write(' to find '),
    println(PlaceName).
    
describe_direction(_, _, _) :-
    write('').
	
location_name(meadow, "Meadow").
location_name(cave, "Cave").
location_name(dragon_cave, "Mountain").
location_name(hill, "Hill").
location_name(forest_entry, "Forest").
location_name(forest(_, _), "Forest").
location_name(spider_forest, "Forest").
location_name(forest_hut, "Forest hut").
