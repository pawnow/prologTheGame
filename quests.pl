:- dynamic active_quest/1, finished_quest/1.

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
	findall(Q, active_quest(Q), Quests),
	write('Current quests: '), nl,
	maplist(print_quests_list, Quests).
	
print_finished_quests :-
	findall(Q, finished_quest(Q), Quests),
	write('Finished quests: '), nl,
	maplist(print_quests_list, Quests).
	
print_quests_list(Quest) :-
	quest(Quest),
	quest_description(Quest, Description),
	write(Quest), write(": "), write(Description), nl.