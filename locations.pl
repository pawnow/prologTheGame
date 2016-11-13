:- dynamic describe/1.

go(XDelta, YDelta) :-
    position(hero, Location),
    location(Location, X, Y),
    X1 is X + XDelta,
    Y1 is Y + YDelta,
    location(NewLocation, X1, Y1),
    retract(position(hero, Location)),
    assert(position(hero, NewLocation)),
    describe_location(NewLocation), !.

go(_, _) :-
    write('That is nothing interesting there, choose other direction'), nl.

go_north :- go(0, 1).
go_south :- go(0, -1).
go_east :- go(1, 0).
go_west :- go(-1, 0).

/*
describe_directions :-
	position(hero, Location),
	location(Location, X, Y),
	XWest is X - 1,
    XEast is X + 1,
    YNorth is Y + 1,
    YSouth is Y - 1,
    describe_direction('You can go West', XWest, Y),
    describe_direction('You can go East', XEast, Y),
    describe_direction('You can go North', X, YNorth),
    describe_direction('You can go South', X, YSouth).

describe_direction(Direction, X, Y) :-
    location(Place, X, Y),
    write(Direction),
    write(' to find '),
    write(Place), nl.
    
describe_direction(_, _, _) :-
    write('').
*/
    
describe_location :-
	position(hero, Location),
	describe_location(Location).

describe_location(meadow) :-
	try((
		position(knife, meadow),
		write("There is a knife lying on the ground."), nl
	)),
	write("You see a cave in the west and a hill in the north."), nl.
        
describe_location(cave) :-
    write("You enter the cave, there is dark inside."), nl.
        
describe_location(dragon_cave) :-
    write("You see a dragon inside the cave."), nl.
    
describe_location(hill) :-
    write("You climb up a hill and look around."), nl,
    try((
		position(location_map, hill),
		write("There is a piece of paper lying on the ground."), nl
	)).
    
describe_location(forest_entry) :-
    write("You're on the edge of an old forest."), nl.
    
describe_location(forest(_, _)) :-
    write("You're inside an old forest."), nl.
    
describe_location(spider_forest) :-
    describe_location(forest(_, _)).
    
describe_location(forest_hut) :-
	write("You're standing in front of a small forest hut but the door is locked."), nl.
	
location_name(meadow, "Meadow").
location_name(cave, "Cave").
location_name(dragon_cave, "Mountain").
location_name(hill, "Hill").
location_name(forest_entry, "Forest").
location_name(forest(_, _), "Forest").
location_name(spider_forest, "Forest").
location_name(forest_hut, "Forest hut").
 

    