:- ['utils'].
:- dynamic achivement/1, visited/1.

characteristic(explorer) :-
	characteristic(curious),
	characteristic(strong).

characteristic(curious) :-
	has(hero, location_map).
	
characteristic(strong) :-
	has(hero, sword).
	
getCharacteristics :-
	findall(C, characteristic(C), Characteristics),
	write('Hero characteristics: '), nl,
	maplist(display_list_element, Characteristics).
	
getCollectedAchievements :-
	findall(A, achivement(A), Achievements),
	write('Collected achivements: '), nl,
	maplist(display_list_element, Achievements).
	