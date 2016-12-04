is_alive(Entity) :-
	health_points(Entity, N),
	N > 0.
	
is_alive(Entity) :-
	not(health_points(Entity, _)).
	
fight(Opponent1, Opponent2) :-
	fight(Opponent1, 0, Opponent2, 0),
	describe_combat(combat_finished(Opponent1, Opponent2)).
	
fight(Opponent1, _, _, _) :-
    not(is_alive(Opponent1)), !.
    
fight(_, _, Opponent2, _) :-
    not(is_alive(Opponent2)), !.
	
fight(Opponent1, Stamina1, Opponent2, Stamina2) :-
	Stamina1 >= 100,
	Stamina1 >= Stamina2,
	attack(Opponent1, Opponent2),
	NewStamina is Stamina1 - 100,
	fight(Opponent1, NewStamina, Opponent2, Stamina2), !.
	
fight(Opponent1, Stamina1, Opponent2, Stamina2) :-
    Stamina2 >= 100,
    attack(Opponent2, Opponent1),
    NewStamina is Stamina2 - 100,
    fight(Opponent1, Stamina1, Opponent2, NewStamina), !.
	
	
fight(Opponent1, Stamina1, Opponent2, Stamina2) :-
    stat(Opponent1, agility, Agility1),
    stat(Opponent2, agility, Agility2),
    NewStamina1 is Stamina1 + Agility1,
    NewStamina2 is Stamina2 + Agility2,
    fight(Opponent1, NewStamina1, Opponent2, NewStamina2), !.
    
    
attack(Opponent1, Opponent2) :-
	stat(Opponent2, luck, Luck),
	random(100) < Luck,
	describe_combat(missed_attack(Opponent1, Opponent2)), !.
    
attack(Opponent1, Opponent2) :-
    stat(Opponent1, strength, Strength),
    stat(Opponent2, defence, Defence),
    Damage is Strength - Defence,
    MaxDamage is max(1, Damage),
    health_points(Opponent2, Health),
    NewHealth is Health - MaxDamage,
    retractall(health_points(Opponent2, _)),
    assertz(health_points(Opponent2, NewHealth)),
    describe_combat(successful_attack(Opponent1, Opponent2, MaxDamage)), !.
    
describe_combat(missed_attack(Opponent1, Opponent2)) :-
	full_subject(Opponent1, Subject1),
	capitalize(Subject1, CapitalizedSubject1),
	full_subject(Opponent2, Subject2),
	subject_pronoun(Opponent2, Pronoun2),
	format("~w tried to attack ~w but ~w evaded the attack.~n", [CapitalizedSubject1, Subject2, Pronoun2]), !.
	
describe_combat(successful_attack(Opponent1, Opponent2, Damage)) :-
    full_subject(Opponent1, Subject1),
    capitalize(Subject1, CapitalizedSubject1),
    full_subject(Opponent2, Subject2),
    subject_pronoun(Opponent2, Pronoun2),
    format("~w attacked ~w and ~w lost ~d health point(s).~n", [CapitalizedSubject1, Subject2, Pronoun2, Damage]), !.
    
describe_combat(combat_finished(Opponent1, Opponent2)) :-
	is_alive(Opponent1),
	full_subject(Opponent1, Subject1),
    capitalize(Subject1, CapitalizedSubject1),
    full_subject(Opponent2, Subject2),
    format("~w killed ~w.~n", [CapitalizedSubject1, Subject2]),
    level_up(Opponent1, Opponent2), !.

describe_combat(combat_finished(Opponent1, Opponent2)) :-
	describe_combat(combat_finished(Opponent2, Opponent1)).
	
level_up(_, dragon) :-
	!.

level_up(hero, _) :-
	level_up.
	
level_up(_, _) :-
	!.

full_subject(hero, "you").
full_subject(dragon, "the dragon").
full_subject(spider, "the spider").
full_subject(snake(_), "the snake").

subject_pronoun(hero, "you").
subject_pronoun(_, "it").
