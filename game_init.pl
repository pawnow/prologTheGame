:- dynamic has/2, health_points/2, location/3, position/2, event/2, is_enemy/1, spider_gone.

:- ['quests'].

location(lake, 2, 7).
location(beach, 2, 6).
location(canyon(north_west), 1, 6).
location(canyon(west), 1, 5).
location(canyon(south_west), 1, 4).
location(canyon(south), 2, 4).
location(canyon(south_east), 3, 4).
location(canyon(east), 3, 5).
location(desert(north_west), 4, 7).
location(desert(north), 5, 7).
location(desert(north_east), 6, 7).
location(desert(west), 4, 6).
location(desert(center), 5, 6).
location(desert(east), 6, 6).
location(desert(south_west), 4, 5).
location(desert(south), 5, 5).
location(desert(south_east), 6, 5).
location(hill, 2, 3).
location(meadow, 2, 2).
location(cave, 1, 2).
location(dragon_cave, 0, 2).
location(forest_entry, 3, 2).
location(forest(far_south_west), 3, 0).
location(forest(far_south), 4, 0).
location(forest(south), 4, 1).
location(forest(center), 4, 2).
location(forest(north), 4, 3).
location(forest(south_east), 5, 1).
location(forest(north_east), 5, 3).
location(forest_hut, 5, 0).

position(hero, meadow).
position(clover, meadow).
position(chest, cave).
position(dragonroots, forest(far_south)).
position(bloodmoss, forest(south_east)).
position(torchlight, forest(north_east)).
position(dragon, dragon_cave).
position(spider, forest(far_south_west)).
position(location_map, beach).
position(chain_armor, desert(center)).
position(snake(west), desert(west)).
position(snake(south), desert(south)).
position(knife, canyon(south_west)).
position(grandma, forest_hut).

is_enemy(snake(_)).

darkness_location(cave).
darkness_location(dragon_cave).

health_points(hero, 100).
health_points(spider, 60).
health_points(dragon, 200).
health_points(snake(west), 50).
health_points(snake(south), 50).

event(start_game, (
	println("You wake up in the middle of the meadow with nothing in hands."),
	start_quest(killing_monsters),
	retractall(event(start_game, _))
)).

event(collect_map, (
	has(hero, location_map),
	println("You've found a map. Type 'map.' to have a closer look."),
	retractall(event(collect_map, _))
)).

event(fight_enemy, (
    position(hero, Position),
    position(Enemy, Position),
    is_enemy(Enemy),
    is_alive(Enemy),
    fight(hero, Enemy)
)).

event(dragon_dead, (
    not(is_alive(dragon)),
    finish_quest(killing_monsters),
    add_achievement("Kill the dragon."),
    retractall(event(dragon_dead, _)),
    println("You've killed the dragon. You're a real hero!"),
    add_killing_achiev,
    retractall(event(fight_dragon, _)),
	retractall(game_in_progress)
)).

event(help_grandma, (
    spider_gone,
    add_achievement("Help the grandma."),
    retractall(event(help_grandma, _))
)).

event(retry, (
    not(is_alive(hero)),
    add_achievement("Die in combat."),
    println("You should in fact stay dead now but somebody has decided to give you another chance."),
    println("Go back to live and finish your mission!"),
    nl,
    replay
)).


add_killing_achiev :-
	not(is_alive(spider)),
	not(is_alive(dragon)),
	not(is_alive(snake(west))),
	not(is_alive(snake(south))),
	add_achievement("You have defeated every enemy that stood in your path. You truly are an ultimate slayer.").
	
add_killing_achiev :-
	spider_gone,
	is_alive(spider),
	is_alive(dragon),
	is_alive(snake(west)),
	is_alive(snake(south)),
	add_achievement("Having completed the game without claiming a single life, you have proven to be a true saint pacifist.").
	
