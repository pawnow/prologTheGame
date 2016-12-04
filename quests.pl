:- dynamic active_quest/1, finished_quest/1.

quest(killing_monsters).
quest(spiderman).
quest(bounty_hunter).
quest(saving_dragon).
quest_description(killing_monsters, "There is a mighty dragon in the west, kill him.").
quest_description(spiderman, "Old grandma is scared of the spider - get rid of it.").
quest_description(bounty_hunter, "Grandma gave you the key to a treasure, find it and get your reward.").
quest_description(saving_dragon, "Dragon asked me to bring him bloodmoss and dragonroots to undo his curse.").

start_quest(QuestName) :-
	retractall(active_quest(QuestName)),
	assertz(active_quest(QuestName)).
	
finish_quest(QuestName) :-
	retractall(active_quest(QuestName)),
	retractall(finished_quest(QuestName)),
	assertz(finished_quest(QuestName)).

quest_log :-
	print_active_quests,
	print_finished_quests.

print_active_quests :-
	write('Current quests: '), nl,
	foreach(active_quest(Q), print_quest(Q)).
	
print_finished_quests :-
	write('Finished quests: '), nl,
	foreach(finished_quest(Q), print_quest(Q)).
	
print_quest(Quest) :-
	quest(Quest),
	quest_description(Quest, Description),
	write(Quest), write(": "), write(Description), nl.
	
spider_gone:-
	not(is_alive(spider)).
	
spider_gone:-
	not(position(spider, _)).