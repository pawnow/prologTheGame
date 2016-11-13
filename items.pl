
is_item(Item) :- is_weapon(Item, _).
is_item(Item) :- is_armor(Item, _).

is_item(location_map).

is_weapon(knife, 2).
is_weapon(sword, 4).

is_armor(chain_armor, 5).

describe_item(location_map) :-
	write('a map of the surrounding area'), nl.

describe_item(knife) :-
	write('a short sharp knife'), nl.

describe_item(sword) :-
	write('a short one-handed sword'), nl.

describe_item(chain_armor) :-
	write('a light chain armor'), nl.

take :-
    position(hero, Location),
    position(Item, Location),
    is_item(Item),
    retractall(position(Item, Location)),
    assertz(has(hero, Item)).
    
    
describe_inventory :-
	write("You have:"), nl,
	foreach(has(hero, Item), describe_item(Item)),
	nl.
	
	