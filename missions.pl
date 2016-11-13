:- dynamic alive/1, inventory/1, location/3, position/3, map_size/2.

reset_mission :-
    retractall(game_in_progress),
    retractall(alive(_)),
    retractall(inventory(_)),
    retractall(location(_, _, _)),
    retractall(position(_, _, _)),
    retractall(map_size(_, _)).
 
init_mission(mission_1) :-
	assertz(map_size(6, 6)),
	assertz(location(forest_spider, 3, 0)),
	assertz(position(spider, 3, 0)),
	assertz(alive(spider)),
	assertz(location(forest_hut, 4, 0)),
	assertz(location(forest, 3, 1)),
	assertz(location(forest, 4, 1)),
	assertz(location(forest, 4, 3)),
	assertz(location(forest, 3, 3)),
	assertz(location(forest_entry, 3, 2)),
	assertz(location(hill, 2, 3)),
	assertz(position(location_map, 2, 3)),
    assertz(location(meadow, 2, 2)),
    assertz(position(hero, 2, 2)),
    assertz(position(knife, 2, 2)),
    assertz(location(cave, 1, 2)),
    assertz(location(boss_cave, 0, 2)),
    assertz(position(dragon, 0, 2)),
    assertz(alive(dragon)).