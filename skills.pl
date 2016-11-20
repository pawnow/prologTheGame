:- dynamic hero/1.

hero_class(dwarf).
hero_class(archer).
hero_class(knight).

skills(hero_class(dwarf), strength(10), defending(0), agility(5)).
skills(hero_class(archer), strength(0), defending(5), agility(10)).
skills(hero_class(knight), strength(5), defending(10), agility(0)).
	
choose_your_class :-
	findall(Class, hero_class(Class), Classes),
	maplist(print_class_information, Classes),
	prompt1("> "),
    read(ChosenClass), nl,
    try_choose_class(ChosenClass).
    
try_choose_class(ChosenClass) :-
	hero_class(ChosenClass),
    assertz(hero(ChosenClass)),
    write('You have chosen class: '), write(ChosenClass), nl.
    
try_choose_class(_) :-
	write('Incorrect choice, try other option'), nl,
	choose_your_class.
    
print_class_information(N) :-
	write('Class: '), write(N), nl,
	skills(hero_class(N), S, D, A),
	write(S), nl,
	write(D), nl,
	write(A), nl,
	write('Type: "'), write(N), write('." to choose this class'), nl.
