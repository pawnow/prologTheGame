:- dynamic chosen_hero_class/1, lvl_bonus/4, trained_stat/2, level/1.

hero_class(dwarf).
hero_class(scout).
hero_class(knight).

stat_type(strength).
stat_type(defence).
stat_type(agility).
stat_type(luck).

class_bonus(dwarf, strength, 20).
class_bonus(dwarf, defence, 5).
class_bonus(dwarf, agility, 5).
class_bonus(dwarf, luck, 25).
class_bonus(scout, strength, 10).
class_bonus(scout, defence, 5).
class_bonus(scout, agility, 10).
class_bonus(scout, luck, 40).
class_bonus(knight, strength, 15).
class_bonus(knight, defence, 10).
class_bonus(knight, agility, 5).
class_bonus(knight, luck, 25).

stat(hero, Stat, Value) :-
	trained_stat(Stat, TrainedStat),
	chosen_hero_class(Class),
    class_bonus(Class, Stat, ClassBonus),
    findall(ItemBonus,
        (has(hero, Item), item_bonus(Item, Stat, ItemBonus)),
        ItemsBonuses),
    list_max(0, ItemsBonuses, ItemsBonus),
    Value is TrainedStat + ClassBonus + ItemsBonus.
    
stat(dragon, strength, 25).
stat(dragon, defence, 8).
stat(dragon, agility, 4).
stat(dragon, luck, 20).

stat(spider, strength, 12).
stat(spider, defence, 5).
stat(spider, agility, 8).
stat(spider, luck, 25).

stat(snake(_), strength, 8).
stat(snake(_), defence, 8).
stat(snake(_), agility, 10).
stat(snake(_), luck, 35).
    
    
    
choose_your_class :-
    println("Choose your class:"),
    foreach(hero_class(Class), print_class_information(Class)),
    prompt1("> "),
    read(ChosenClass), nl,
    try_choose_class(ChosenClass).
    
try_choose_class(ChosenClass) :-
    hero_class(ChosenClass),
    retractall(chosen_hero_class(_)),
    assertz(chosen_hero_class(ChosenClass)),
    retractall(level(_)),
    assertz(level(1)),
    retractall(trained_stat(_, _)),
    assertz(trained_stat(strength, 0)),
    assertz(trained_stat(defence, 0)),
    assertz(trained_stat(agility, 0)),
    assertz(trained_stat(luck, 0)),
    write('You have chosen class: '), write(ChosenClass), nl, !.
    
try_choose_class(_) :-
    println('Incorrect choice, try other option'),
    choose_your_class.
    
print_class_information(Class) :-
    write('Class: '), write(Class), nl,
    forall(stat_type(Stat), (
        class_bonus(Class, Stat, Value),
        write(Stat), write(": "), write(Value), nl
    )),
    write('Type: "'), write(Class), write('." to choose this class.'), nl, nl.
    
    
level_up :- 
    println('You have increased your level.'),
    print_current_stats,
    forall(stat_type(Stat), (
        write('Write "'), write(Stat), write('." to increase this stat by one.'), nl
    )),
    prompt1("> "),
    read(ChosenStat), nl,
    try_choose_value_to_go_up(ChosenStat).
    
try_choose_value_to_go_up(Stat) :-
    trained_stat(Stat, Num),
    level(Lvl),
    NumUp is Num + 1,
    LvlUp is Lvl + 1,
    retractall(trained_stat(Stat, _)),
    assertz(trained_stat(Stat, NumUp)),
    retractall(level(_)),
    assertz(level(LvlUp)),
    println('Stats after leveling up: '),
    print_current_stats.
    
try_choose_value_to_go_up(_) :-
    println('Incorrect choice, try other option'),
    level_up.

print_current_stats :- 
    level(Lvl),
    println('Current player stats: '),
    write('Level: '), println(Lvl),
    forall(stat_type(Stat), (
        stat(hero, Stat, Value),
        write(Stat), write(": "), write(Value), nl
    )),
    nl.
    