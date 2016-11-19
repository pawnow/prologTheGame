:- ['utils'].

show_map :-
	has(hero, location_map),
	draw_map.
	
map_edges(XMin, YMin, XMax, YMax) :-
	findall(X, location(_, X, _), Xs),
	findall(Y, location(_, _, Y), Ys),
	min_member(XMin, Xs),
	min_member(YMin, Ys),
	max_member(XMax, Xs),
	max_member(YMax, Ys).
	
map_slot_width(16).

draw_map :-
	map_edges(XMin, YMin, XMax, YMax),
	Width is XMax - XMin + 1,
	draw_horizontal_border(Width),
	foreach(between_down(YMax, YMin, Row), (
		draw_map_row(Row),
		draw_horizontal_border(Width)
	)).

draw_horizontal_border(MapWidth) :-
	map_slot_width(SlotWidth),
	CharsCount is MapWidth * (SlotWidth + 1) + 1,
	print_repeated("#", CharsCount), nl.

draw_map_row(Row) :-
	map_edges(XMin, _, XMax, _),
	write("#"),
	foreach(between(XMin, XMax, Column), (
		print_place_name(Column, Row),
		write("#")
	)),
	nl.

print_place_name(X, Y) :-
	location(Place, X, Y),
	location_name(Place, Name),
	string_length(Name, L),
	map_slot_width(N),
	PaddingLength is N - L,
	write(Name), print_repeated(" ", PaddingLength).
	
print_place_name(_, _) :-
	map_slot_width(N),
	print_repeated(" ", N).
	