dynamic has/2, helth_points/2.

:- ['utils', 'items'].

alive(Entity) :-
	helth_points(Entity, N),
	N > 0.
	

strength(hero, N) :-
	findall(Strength,
		(has(hero, Weapon), is_weapon(Weapon, Strength)),
		Strengths),
	list_max(0, Strengths, N).
	
	
strength(dragon, 10).

defense(hero, N) :-
	findall(Defense,
		(has(hero, Armor), is_armor(Armor, Defense)),
		Defenses),
	list_max(0, Defenses, N).
	
defense(dragon, 5).

defeats(Winner, Loser) :-
	helth_points(Winner, WinnerHelth),
	helth_points(Loser, LoserHelth),
	defeats(Winner, WinnerHelth, Loser, LoserHelth).
	
defeats(_, WinnerHelth, _, LoserHelth) :-
	WinnerHelth > 0,
	LoserHelth =< 0.
	
defeats(Winner, WinnerHelth, Loser, LoserHelth) :-
	strength(Winner, WinnerStrength),
	strength(Loser, LoserStrength),
	defense(Winner, WinnerDefense),
	defense(Loser, LoserDefense),
	DamageToWinner is LoserStrength - WinnerDefense,
	MaxDamageToWinner is max(0, DamageToWinner),
	WinnerHelth1 is WinnerHelth - MaxDamageToWinner,
	DamageToLoser is WinnerStrength - LoserDefense,
	MaxDamageToLoser is max(0, DamageToLoser),
	LoserHelth1 is LoserHelth - MaxDamageToLoser,
	defeats(Winner, WinnerHelth1, Loser, LoserHelth1).
	