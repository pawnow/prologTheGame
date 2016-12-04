%Control flow

try(X) :- call(X), !; true.

between_down(From, DownTo, From) :-
	From >= DownTo.
	
between_down(From, DownTo, X) :-
	NextFrom is From - 1,
	NextFrom >= DownTo,
	between_down(NextFrom, DownTo, X).

between_down(_, _, _) :- fail.

%Math

list_max(Min, [], Min).

list_max(Min, [H | T], Max) :-
	Min1 is max(Min, H),
	list_max(Min1, T, Max).
	

%Text

print_repeated(Str, Count) :-
	foreach(between(1, Count, _), write(Str)).
	
println(Text) :-
	write(Text), nl.
	
capitalize(Text, CapitalizedText) :-
	string_chars(Text, [FirstChar | Chars]),
	upcase_atom(FirstChar, FirstCapital),
	string_chars(CapitalizedText, [FirstCapital | Chars]).

%Files	 
		 
project_path(ProjectPath) :-
	source_file(FilePath),
	split_string(FilePath, "/", "/", PathElems),
	last(PathElems, LastElem),
	LastElem = "the_game.pl",
	atom_concat(FilePath, '/..', RootDirPath),
	absolute_file_name(RootDirPath, ProjectPath), !.
	
consult_local(FileName) :-
	project_path(ProjectPath),
	atom_concat(ProjectPath, '/', ProjectPathWithSeparator),
	atom_concat(ProjectPathWithSeparator, FileName, FullFilePath),
	consult(FullFilePath), !.