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
	foreach(characteristics(C), println(C)).
	
print_collected_achievements :-
	println('Collected achivements: '),
	foreach(achivement(A), println(A)).
	