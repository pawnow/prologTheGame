:- dynamic has/2, health_points/2, location/3, position/2, event/2.

:- ['quests'].

location(meadow, 2, 2).
location(cave, 1, 2).
location(dragon_cave, 0, 2).
location(spider_forest, 3, 0).
location(forest_hut, 5, 0).
location(forest(4, 0), 4, 0).
location(forest(4, 1), 4, 1).
location(forest(4, 2), 4, 2).
location(forest(5, 1), 5, 1).
location(forest(5, 3), 5, 3).
location(forest(4, 3), 4, 3).
location(forest_entry, 3, 2).
location(hill, 2, 3).

position(hero, meadow).
position(knife, meadow).
position(chest, cave).
position(key, forest_hut).
position(dragonroots, forest(4, 0)).
position(bloodmoss, forest(5, 1)).
position(torchlight, forest(5, 3)).
position(dragon, dragon_cave).
position(spider, spider_forest).
position(location_map, hill).

darkness_location(cave).
darkness_location(dragon_cave).

health_points(hero, 20).
health_points(spider, 10).
health_points(dragon, 30).

event(start_game, (
	write("You wake up in the middle of the meadow with nothing in hands."), nl,
	startQuest(killing_monsters),
	retractall(event(start_game, _))
)).

event(fight_dragon, (
	position(hero, dragon_cave),
	write("The dragon kills you. Sad but"), nl,
	retractall(event(fight_dragon, _)),
	retractall(game_in_progress)
)).

event(collect_map, (
	has(hero, location_map),
	write("You've found a map. Type 'map.' to have a closer look."), nl,
	retractall(event(collect_map, _))
)).
