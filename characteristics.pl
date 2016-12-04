:- ['utils'].
:- dynamic achivement/1, visited/1.

characteristics(explorer) :-
	characteristics(curious),
	characteristics(strong).

characteristics(curious) :-
	has(hero, location_map).
	
characteristics(strong) :-
	has(hero, sword).
	
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
	