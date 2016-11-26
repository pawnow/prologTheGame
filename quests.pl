:- dynamic active_quest/1, finished_quest/1, spider_killed, spider_escaped.

quest(killing_monsters).
quest(spiderman).
quest(bounty_hunter).
quest_description(killing_monsters, "There is a mighty dragon in the west, kill him.").
quest_description(spiderman, "Old grandma is scared of the spider - get rid of it.").
quest_description(bounty_hunter, "Grandma gave you a key to treasure, find it and get your reward.").

start_quest(QuestName) :-
	assertz(active_quest(QuestName)).
	
finish_quest(QuestName) :-
	active_quest(QuestName),
	retractall(active_quest(QuestName)),
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
	spider_killed.
	
spider_gone:-
	spider_escaped.