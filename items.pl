
is_item(location_map).
is_item(torchlight).
is_item(dragonroots).
is_item(bloodmoss).
is_item(key).

is_item(Item) :- is_weapon(Item, _).
is_item(Item) :- is_armor(Item, _).

is_weapon(knife, 2).
is_weapon(sword, 4).

is_armor(chain_armor, 5).

describe_item(location_map) :-
	write('a map of the surrounding area.'), nl.

describe_item(knife) :-
	write('a short sharp knife.'), nl.

describe_item(sword) :-
	write('a short one-handed sword.'), nl.

describe_item(chain_armor) :-
	write('a light chain armor.'), nl.
	
describe_item(torchlight) :-
	write('a torchlight giving lots of light.'), nl.
	
describe_item(dragonroots) :-
	write('dragonroots - rare plant.'), nl.
	
describe_item(bloodmoss) :-
	write('bloodmoss - common herb.'), nl.
	
describe_item(key) :-
	write('a key to the chest.'), nl.

take :-
    position(hero, Location),
    position(Item, Location),
    is_item(Item),
    retractall(position(Item, Location)),
    assertz(has(hero, Item)).
    
chest_is_visible(Location) :- 
	position(chest, Location),
	not(darkness_location(Location)).
	
chest_is_visible(Location) :- 
	position(chest, Location),
	darkness_location(Location),
	has(hero, torchlight).

open_chest :-
	position(hero, Location),
	chest_is_visible(Location),
	has(hero, key),
	assertz(has(hero, sword)),
	write("You opened the chest and found new sword."), nl.
	
open_chest :-
	write("You need to find a chest and have key to open it."), nl.
    
describe_inventory :-
	write("You have:"), nl,
	foreach(has(hero, Item), describe_item(Item)),
	nl.
	
	