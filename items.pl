is_item(Item) :- is_weapon(Item, _).
is_item(Item) :- is_armor(Item, _).

is_item(location_map).
is_weapon(knife, 2).
is_weapon(sword, 4).

is_armor(chain_armor, 5).