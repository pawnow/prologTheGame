is_item(location_map).
is_item(torchlight).
is_item(dragonroots).
is_item(bloodmoss).
is_item(key).
is_item(clover).

is_item(Item) :- is_weapon(Item).
is_item(Item) :- is_armor(Item).

is_weapon(knife).
is_weapon(sword).

is_armor(chain_armor).

item_bonus(knife, strength, 2).
item_bonus(sword, strength, 4).
item_bonus(chain_armor, defence, 5).
item_bonus(clover, luck, 10).

item_description(location_map, 'a map of the surrounding area.').
item_description(knife, 'a short sharp knife.').
item_description(sword, 'a short one-handed sword.').
item_description(chain_armor, 'a light chain armor.').
item_description(torchlight, 'a torchlight giving lots of light.').
item_description(dragonroots, 'dragonroots - rare plant.').
item_description(bloodmoss, 'bloodmoss - common herb.').
item_description(key, 'a key to the chest.').
item_description(clover, 'a four-leaf clover - people say it brings luck.').

take :-
    position(hero, Location),
    position(Item, Location),
    is_item(Item),
    retractall(position(Item, Location)),
    assertz(has(hero, Item)).
    
is_visible(Object, Location) :- 
	position(hero, Location),
	position(Object, Location),
	not(darkness_location(Location)).
	
is_visible(Object, Location) :- 
	position(hero, Location),
	position(Object, Location),
	darkness_location(Location),
	has(hero, torchlight).

open_chest :-
	position(hero, Location),
	is_visible(chest, Location),
	has(hero, key),
	assertz(has(hero, sword)),
	println("You opened the chest and found new sword."),
	add_achievement("Get reward from the chest."),
	level_up.
	
open_chest :-
	println("You need to find a chest and have key to open it.").
    
describe_item(Item) :-
	item_description(Item, Description),
	println(Description).

describe_inventory :-
	println("You have:"),
	foreach(has(hero, Item), describe_item(Item)),
	nl.
	
	