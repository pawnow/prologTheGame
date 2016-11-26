:- dynamic hero/1, lvl_bonus/4, stat_bonus/2, level/1.

hero_class(dwarf).
hero_class(archer).
hero_class(knight).

stat(strength).
stat(defence).
stat(agility).

skills(hero_class(dwarf), strength(10), defence(0), agility(5)).
skills(hero_class(archer), strength(0), defence(5), agility(10)).
skills(hero_class(knight), strength(5), defence(10), agility(0)).
	
choose_your_class :-
	println("Choose your class:"),
	foreach(hero_class(Class), print_class_information(Class)),
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
    assertz(stat_bonus(defence, 0)),
    assertz(stat_bonus(agility, 0)),
    write('You have chosen class: '), write(ChosenClass), nl.
    
try_choose_class(_) :-
	println('Incorrect choice, try other option'),
	choose_your_class.
    
print_class_information(N) :-
	write('Class: '), write(N), nl,
	skills(hero_class(N), S, D, A),
	println(S),
	println(D),
	println(A),
	write('Type: "'), write(N), write('." to choose this class'), nl.
	
level_up :- 
	println('You have increased your level.'),
	print_current_stats,
	foreach(stat_bonus(Stat, _), print_possible_stats_to_grow(Stat)),
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
	println('Stats after leveling up: '),
	print_current_stats.
	
try_choose_value_to_go_up(_) :-
	println('Incorrect choice, try other option'),
	level_up.

print_current_stats :- 
	hero(ChosenClass),
	skills(hero_class(ChosenClass), strength(S), defence(D), agility(A)),
	level(Lvl),
	stat_bonus(strength, StrengthBonus),
	stat_bonus(defence, DefenceBonus),
	stat_bonus(agility, AgilityBonus),
	Strength is S + StrengthBonus,
	Defence is D + DefenceBonus,
	Agility is A + AgilityBonus,
	println('Current player stats: '),
	write('Level: '), println(Lvl),
	println(strength(Strength)),
	println(defence(Defence)),
	println(agility(Agility)).
	