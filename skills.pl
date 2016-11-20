:- dynamic hero/1, lvl_bonus/4, stat_bonus/2, level/1.

hero_class(dwarf).
hero_class(archer).
hero_class(knight).

stat(strength).
stat(defending).
stat(agility).

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
	retractall(hero(_)),
    assertz(hero(ChosenClass)),
    retractall(level(_)),
    assertz(level(1)),
    retractall(stat_bonus(_, _)),
    assertz(stat_bonus(strength, 0)),
    assertz(stat_bonus(defending, 0)),
    assertz(stat_bonus(agility, 0)),
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
	
levelUp :- 
	write('You have increased your level.'), nl,
	printCurrentStats,
	findall(Stat, stat_bonus(Stat, _), Stats),
	maplist(print_possible_stats_to_grow, Stats),
	prompt1("> "),
    read(ChosenStat), nl,
    try_choose_value_to_go_up(ChosenStat).
	
print_possible_stats_to_grow(Stat) :-
	stat_bonus(Stat, _),
	write('Write "'), write(Stat), write('." to increase this stat by one.'), nl.
	
try_choose_value_to_go_up(Stat) :-
	stat_bonus(Stat, Num),
	level(Lvl),
	NumUp is Num + 1,
	LvlUp is Lvl + 1,
	retractall(stat_bonus(Stat, _)),
	assertz(stat_bonus(Stat, NumUp)),
	retractall(level(_)),
	assertz(level(LvlUp)),
	write('Stats after leveling up: '), nl,
	printCurrentStats.
	
try_choose_value_to_go_up(_) :-
	write('Incorrect choice, try other option'), nl,
	levelUp.

printCurrentStats :- 
	hero(ChosenClass),
	skills(hero_class(ChosenClass), strength(S), defending(D), agility(A)),
	level(Lvl),
	stat_bonus(strength, StrengthBonus),
	stat_bonus(defending, DefendingBonus),
	stat_bonus(agility, AgilityBonus),
	Strength is S + StrengthBonus,
	Defending is D + DefendingBonus,
	Agility is A + AgilityBonus,
	write('Current player stats: '), nl,
	write('Level: '), write(Lvl), nl,
	write(strength(Strength)), nl,
	write(defending(Defending)), nl,
	write(agility(Agility)), nl.
	