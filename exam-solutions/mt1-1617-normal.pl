:- use_module(library(lists)).
:- use_module(library(sets)).

% film(Title, Categories, Duration, Voting).
film('Doctor Strange', [action, adventure, fantasy], 115, 7.6).
film('Hacksaw Ridge', [biography, drama, romance], 131, 8.7).
film('Inferno', [action, adventure, crime], 121, 6.4).
film('Arrival', [drama, mystery, scifi], 116, 8.5).
film('The Accountant', [action, crime, drama], 127, 7.6).
film('The Girl on the Train', [drama, mystery, thriller], 112, 6.7).
 
% user(Username, YearOfBirth, Country)
user(john, 1992, 'USA').
user(jack, 1989, 'UK').
user(peter, 1983, 'Portugal').
user(harry, 1993, 'USA').
user(richard, 1982, 'USA').
 
% vote(Username, List_of_Film-Rating)
vote(john, ['Inferno'-7, 'Doctor Strange'-9, 'The Accountant'-6]).
vote(jack, ['Inferno'-8, 'Doctor Strange'-8, 'The Accountant'-7]).
vote(peter, ['The Accountant'-4, 'Hacksaw Ridge'-7, 'The Girl on the Train'-3]).
vote(harry, ['Inferno'-7, 'The Accountant'-6]).
vote(richard, ['Inferno'-10, 'Hacksaw Ridge'-10, 'Arrival'-9]).

/**
	Pergunta #1
**/
curto(Movie) :-
	film(Movie, _, Duration, _),
	Duration < 125.

/**
	Pergunta #2
**/
diff(User1, User2, Difference, Film) :-
	vote(User1, Votes1),
	vote(User2, Votes2),

	member(Film-Rating1, Votes1),
	member(Film-Rating2, Votes2),

	Difference is abs(Rating2 - Rating1).

/**
	Pergunta #3
**/
niceGuy(User) :-
	vote(User, Ratings),
	count_good_ratings(Ratings, Count),
	Count >= 2.

count_good_ratings([_-Rating|T], Count) :-
	Rating >= 8,
	count_good_ratings(T, NewCount),
	Count is NewCount + 1.

count_good_ratings([], 0).

/**
	Pergunta #4
**/
elemsComuns(List1, Common, List2) :-
	intersection(List1, List2, Common).

elemsComunsV2([H|T], Common, List2) :-
	member(H, List2),
	elemsComunsV2(T, OldCommon, List2),
	append([H], OldCommon, Common), !.

elemsComunsV2([_|T], Common, List2) :-
	elemsComunsV2(T, Common, List2).	

elemsComunsV2([], [], _).

/**
	Pergunta #5
**/
printCategory(Category) :-
	film(Title, CategoryList, Duration, Rating),
	member(Category, CategoryList),

	write(Title), write(' ('), 
	write(Duration), write('min, '),
	write(Rating), write('/10)'), nl, fail.

printCategory(_).

/**
	Pergunta #6
**/
similarity(Film1, Film2, Similarity) :-
	film(Film1, Categories1, Duration1, Rating1),
	film(Film2, Categories2, Duration2, Rating2),

	intersection(Categories1, Categories2, Common),

	append(Categories1, Categories2, DupedDiff),
	remove_dups(DupedDiff, Diff),

	length(Common, CommonNum),
	length(Diff, DiffNum),

	PercentCommonCat is (CommonNum / DiffNum) * 100,
	DurationDiff is abs(Duration2 - Duration1),
	ScoreDiff is abs(Rating2 - Rating1),

	Similarity is float(round(PercentCommonCat - 3 * DurationDiff - 5 * ScoreDiff)).

/**
	Pergunta #7
**/
mostSimilar(Film, Similarity, Films) :-
	findall(Title, (film(Title, _, _, _), high_similarity(Film, Title)), Films),
	get_similarity_list(Film, Films, Similarities),
	max_member(Similarity, Similarities).

high_similarity(Film, Title) :-
	Film \= Title,
	similarity(Film, Title, Similarity),
	Similarity > 10.

get_similarity_list(Film, [H|T], Similarities) :-
	similarity(Film, H, Similarity),
	get_similarity_list(Film, T, OldSim),
	append([Similarity], OldSim, Similarities).

get_similarity_list(_, [], [0.0]).

/**
	Pergunta #8
**/
distancia(User1, Distancia, User2) :-
	user(User1, Birth1, Country1),
	user(User2, Birth2, Country2),

	vote(User1, Votes1), vote(User2, Votes2),
	get_titles_from_pairs(Votes1, Titles1), get_titles_from_pairs(Votes2, Titles2),

	elemsComuns(Titles1, CommonMovies, Titles2),
	get_diff_sum(CommonMovies, User1, User2, DiffSum),

	length(CommonMovies, DiffLength),

	AvgDiff is DiffSum / DiffLength,
	AgeDiff is abs(Birth1 - Birth2),
	((Country1 \= Country2, CountryDiff is 2); (Country1 = Country2, CountryDiff is 0)),

	Distancia is AvgDiff + AgeDiff / 3 + CountryDiff.

get_diff_sum([H|T], User1, User2, SumDiff) :-
	diff(User1, User2, Diff, H),
	get_diff_sum(T, User1, User2, AccDiff),
	SumDiff is AccDiff + Diff.

get_diff_sum([], _, _, 0).

get_titles_from_pairs([Title-_|T], [Title|T1]) :-
	get_titles_from_pairs(T, T1).

get_titles_from_pairs([], []).




