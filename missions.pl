:- dynamic alive/1, inventory/1, location/3, position/3.

reset_mission :-
    retractall(game_in_progress),
    retractall(alive(_)),
    retractall(inventory(_)),
    retractall(location(_, _, _)),
    retractall(position(_, _, _)).
 
init_mission(mission_1) :-
    assertz(location(meadow, 2, 2)),
    assertz(position(hero, 2, 2)),
    assertz(position(knife, 2, 2)),
    assertz(location(cave, 1, 2)),
    assertz(location(boss_cave, 0, 2)),
    assertz(position(dragon, 0, 2)),
    assertz(alive(dragon)).