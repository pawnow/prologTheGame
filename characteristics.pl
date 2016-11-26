:- ['utils'].
:- dynamic achivement/1, visited/1.

characteristics(explorer) :-
	characteristic(curious),
	characteristic(strong).

characteristics(curious) :-
	has(hero, location_map).
	
characteristics(strong) :-
	has(hero, sword).
	
print_characteristics :-
	findall(C, characteristics(C), Characteristics),
	println('Hero characteristics: '),
	maplist(display_list_element, Characteristics).
	
print_collected_achievements :-
	findall(A, achivement(A), Achievements),
	println('Collected achivements: '),
	maplist(display_list_element, Achievements).
	