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
raro(Movie) :-
	film(Movie, _, Duration, _),
	(Duration < 60; Duration > 120).

/**
	Pergunta #2
**/
happierGuy(User1, User2, HappierGuy) :-
	vote(User1, List1), 
	vote(User2, List2),

	get_values_from_pairs(List1, Values1),
	get_values_from_pairs(List2, Values2), 

	sumlist(Values1, Sum1),
	sumlist(Values2, Sum2),

	length(List1, Length1), 
	length(List2, Length2),

	Average1 is Sum1 / Length1, 
	Average2 is Sum2 / Length2,

	Average1 > Average2, HappierGuy = User1, !.

happierGuy(_, User2, HappierGuy) :-
	HappierGuy = User2.

get_values_from_pairs([_-Rating|T], [Rating|T1]) :-
	get_values_from_pairs(T, T1).

get_values_from_pairs([], []).

/**
	Pergunta #3
**/
likedBetter(User1, User2) :-
	vote(User1, List1), vote(User2, List2),

	get_values_from_pairs(List1, Values1), 
	get_values_from_pairs(List2, Values2),

	select_max(Max1, Values1, _),
	select_max(Max2, Values2, _),

	Max1 > Max2.

/**
	Pergunta #4
**/
recommends(User, Movie) :-
	vote(User, MoviesSeen),
	vote(_, MoviesMatch),

	get_titles_from_pairs(MoviesSeen, Titles1),
	get_titles_from_pairs(MoviesMatch, Titles2),

	check_if_same_movies(Titles1, Titles2),

	nth0(_, Titles2, UnseenMovie),
	\+ member(UnseenMovie, Titles1), !,
	Movie = UnseenMovie.

check_if_same_movies([H|T], List) :-
	member(H, List),
	check_if_same_movies(T, List).

check_if_same_movies([], _).

get_titles_from_pairs([Title-_|T], [Title|T1]) :-
	get_titles_from_pairs(T, T1).

get_titles_from_pairs([], []).

/**
	Pergunta #5
	Nota: Não acho que haja forma de resolver sem declarar o predicado vote como dinâmico.
**/
:- dynamic vote/2.
invert(PredicateSymbol/Arity) :-
	functor(T, PredicateSymbol, Arity),
	retract(T),
	asserta(T), fail.

invert(_).

/**
	Pergunta #6
	Nota: Se a biblioteca 'sets' não for permitida - o que creio ser -, a solução é inválida.
**/
onlyOne(User1, User2, OnlyOneList) :-
	vote(User1, List1), vote(User2, List2),

	get_titles_from_pairs(List1, Titles1),
	get_titles_from_pairs(List2, Titles2),

	subtract(Titles1, Titles2, Dif1),
	subtract(Titles2, Titles1, Dif2),
	append(Dif1, Dif2, OnlyOneList).

/**
	Pergunta #7
**/
:- dynamic filmUsersVotes/2.

filmVoting :-
	film(Title, _, _, _),
	assertz(filmUsersVotes(Title, [])),

	vote(User, VoteList),
	nth0(_, VoteList, Title-Rating),

	filmUsersVotes(Title, UserVoteList),
	append(UserVoteList, [User-Rating], ReadyList),

	retract(filmUsersVotes(Title, _)),
	assertz(filmUsersVotes(Title, ReadyList)), fail.

filmVoting :- 
	listing(filmUsersVotes).

/**
	Pergunta #8
**/
dumpDataBase(FileName) :-
	open(FileName, append, File),

	tell(File),
	listing(film),
	listing(user),
	listing(vote),
	told.


	


	