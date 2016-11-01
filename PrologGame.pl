 :- dynamic level/1, hero_position/3, alive/1, position/2, equipment/1, equipmentPosition/3.
hero_position(meadow,2,2).
location(meadow, 2, 2).
location(cave, 1, 2).
location(cave_boss, 0, 2).
equipmentPosition(sword, 2, 2).

position(cave_boss, dragon).
alive(dragon).

north :- go(0, 1).
south :- go(0, -1).
east :- go(-1, 0).
west :- go(1, 0).

go(XDelta, YDelta) :-
        hero_position(Place, X, Y),
		X1 is X + XDelta,
		Y1 is Y + YDelta,
        location(NewPlace, X1, Y1),
        retract(hero_position(Place, X, Y)),
        assert(hero_position(NewPlace, X1, Y1)),
        show, !.

go(_) :-
        write('That is nothing interesting there, choose other direction').

show :-
        hero_position(Place, X, Y),
        describe(Place),
		describeActions(Place, X, Y),
        nl.

start :-
        show.
		
take :-
	hero_position(_,X,Y),
	equipmentPosition(Equipment, X, Y),
	retract(equipmentPosition(Equipment, X, Y)),
    assert(equipment(Equipment)).

describe(meadow) :-
        write('You wake up in the middle of the meadow with nothing in hands.'), nl,
        write('You see a cave in the east'), nl.
		
describe(cave) :-
        write('You enter the cave, there is dark inside.'), nl.
		
describe(cave_boss) :-
        write('You see a dragon inside a cave and it kills you.'), nl.

describe(_, _) :-
	write('').
	
describeActions(Place, X, Y) :-
	nl, write('Possible actions in the current location:'), nl,
	XWest is X + 1,
	XEast is X - 1,
	YNorth is Y + 1,
	YSouth is Y - 1,
	describeDirection('You can go West', XWest, Y),
	describeDirection('You can go East', XEast, Y),
	describeDirection('You can go North', X, YNorth),
	describeDirection('You can go South', X, YSouth),
	describeTakingEquipment(X, Y).

describeDirection(Direction, X, Y) :-
	location(Place, X, Y),
	write(Direction),
	write(' to find '),
	write(Place), nl.
	
describeDirection(_, _, _) :-
	write('').
	
describeTakingEquipment(X, Y):-
	equipmentPosition(Equipment, X, Y),
	write('You can take '),
	write(Equipment),
	write(' by writing ''take.'''), nl.

describeTakingEquipment(_, _) :-
	write('').
