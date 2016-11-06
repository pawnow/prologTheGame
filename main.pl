 :- ['items', 'missions'].
 
 :- dynamic alive/1, inventory/1, location/3, position/3, is_person/1, game_in_progress/0.
    
restart :-
    reset_mission,
    init_mission(mission_1),
    assertz(game_in_progress),
    continue.
    
continue :-
    show,
    prompt_action.
    
    
user_action(east).
user_action(west).
user_action(north).
user_action(south).
user_action(take).
user_action(show).
user_action(help).
    
try_call(Action) :-
    call(Action).
    
try_call(_).
    
perform_user_action(quit).

perform_user_action(Action) :-
    user_action(Action),
    try_call(Action),
    prompt_action.
    
perform_user_action(Action) :-
    write("Cannot perform action '"), write(Action), write("'"), nl,
    prompt_action.
    
prompt_action :-
    game_in_progress,
    prompt1("> "),
    read(Action), nl,
    perform_user_action(Action).
    
prompt_action.


north :- go(0, 1).
south :- go(0, -1).
east :- go(1, 0).
west :- go(-1, 0).

go(XDelta, YDelta) :-
    position(hero, X, Y),
    X1 is X + XDelta,
    Y1 is Y + YDelta,
    location(_, X1, Y1),
    retract(position(hero, X, Y)),
    assert(position(hero, X1, Y1)),
    show, !.

go(_) :-
    write('That is nothing interesting there, choose other direction').

show :-
    position(hero, X, Y),
    location(Place, X, Y),
    describe(Place),
    describe_actions_for_location(X, Y),
    nl, !.

start :-
    show.
        
take :-
    position(hero, X, Y),
    position(Item, X, Y),
    is_item(Item),
    retract(position(Item, X, Y)),
    assertz(inventory(Item)).

describe(meadow) :-
    write('You wake up in the middle of the meadow with nothing in hands.'), nl,
    write('You see a cave in the west'), nl.
        
describe(cave) :-
    write('You enter the cave, there is dark inside.'), nl.
        
describe(boss_cave) :-
    write('You see a dragon inside a cave and it kills you.'), nl,
    retract(game_in_progress).

describe(_) :-
    write('').
    
describe_actions_for_location(X, Y) :-
    game_in_progress,
    nl, write('Possible actions in the current location:'), nl,
    XWest is X - 1,
    XEast is X + 1,
    YNorth is Y + 1,
    YSouth is Y - 1,
    describe_direction('You can go West', XWest, Y),
    describe_direction('You can go East', XEast, Y),
    describe_direction('You can go North', X, YNorth),
    describe_direction('You can go South', X, YSouth),
    findall(Object, position(Object, X, Y), Objects),
    describe_actions_for_objects(Objects), !.
    
describe_actions_for_location(_, _).
    
describe_actions_for_objects([Object | Objects]) :-
    describe_action_for_object(Object),
    describe_actions_for_objects(Objects).
    
describe_actions_for_objects([]).

describe_action_for_object(Object) :-
    is_item(Object),
    write('You can take '),
    write(Object),
    write(' by writing ''take.'''), nl.
    
describe_action_for_object(Object) :-
    is_person(Object),
    write('You can talk to '),
    write(Object),
    write(' by writing ''talk.'''), nl.
    
describe_action_for_object(_).

describe_direction(Direction, X, Y) :-
    location(Place, X, Y),
    write(Direction),
    write(' to find '),
    write(Place), nl.
    
describe_direction(_, _, _) :-
    write('').
