test(fight(1, Enemy)) :-
	reset_game,
    initialize_world,
    try_choose_class(scout),
	fight(hero, Enemy).
	
test(fight(2, Enemy)) :-
    reset_game,
    initialize_world,
    assertz(has(hero, sword)),
    assertz(has(hero, chain_armor)),
    try_choose_class(scout),
    fight(hero, Enemy).