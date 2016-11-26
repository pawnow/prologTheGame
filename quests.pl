:- dynamic not_discovered_quest/1, current_quest/1, finished_quest/1.

quest(killing_monsters).
quest(spiderman).
quest(bounty_hunter).
quest_description(killing_monsters, "There is a mighty dragon in the west, kill him.").
quest_description(spiderman, "Old grandma is scared of the spider - get rid of it.").
quest_description(bounty_hunter, "Grandma gave you a key to treasure, find it and get your reward.").
not_discovered_quest(killing_monsters).
not_discovered_quest(spiderman).
not_discovered_quest(bounty_hunter).

startQuest(QuestName) :-
	not_discovered_quest(QuestName),
	retractall(not_discovered_quest(QuestName)),
	assertz(current_quest(QuestName)).
	
finishQuest(QuestName) :-
	current_quest(QuestName),
	retractall(current_quest(QuestName)),
	assertz(finished_quest(QuestName)).

questLog :-
	getCurrentQuests,
	getFinishedQuests.

getCurrentQuests :-
	findall(Q, current_quest(Q), Quests),
	write('Current quests: '), nl,
	maplist(display_quests_list, Quests).
	
getFinishedQuests :-
	findall(Q, finished_quest(Q), Quests),
	write('Finished quests: '), nl,
	maplist(display_quests_list, Quests).
	
display_quests_list(Quest) :-
	quest(Quest),
	quest_description(Quest, Description),
	write(Quest), write(": "), write(Description), nl.