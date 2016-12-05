:- ['utils'].
:- dynamic achievement/1, visited/1.

characteristics(perceptive) :-
	has(hero, location_map).

characteristics(strong) :-
	has(hero, sword).

characteristics(lucky) :-
	has(hero, clover).

characteristics(rational) :-
	has(hero, torchlight).

characteristics(noble) :-
	spider_gone,
	is_alive(spider).
	
characteristics(fearless) :-
	finished_quest(killing_monsters).

characteristics(reliable) :-
	finished_quest(spiderman).	

characteristics(smart) :-
	finished_quest(bounty_hunter).
	
characteristics(heroic) :-
	finished_quest(saving_dragon).
	
characteristics(herbalist) :-
	has(hero, dragonroots),
	has(hero, bloodmoss).

characteristics(explorer) :-
	characteristics(perceptive),
	characteristics(lucky),
	characteristics(rational).
	
characteristics(knight) :-
	characteristics(strong),
	characteristics(perceptive),
	characteristics(fearless).
	
characteristics(scientist) :-
	characteristics(smart),
	characteristics(rational).
	
characteristics(hero) :-
	characteristics(heroic),
	characteristics(reliable),
	characteristics(noble).
	
print_characteristics :-
	println('Hero characteristics: '),
	forall(characteristics(C), println(C)),
	nl.
	
print_collected_achievements :-
	println('Collected achivements: '),
	forall(achievement(A), println(A)),
	nl.
	
add_achievement(A) :-
	retractall(achievement(A)),
	assertz(achievement(A)).
	