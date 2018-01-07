:- use_module(library(clpfd)).
:- use_module(library(lists)).

% Pergunta #12, exame 2015/2016
ups_and_downs(Min, Max, N, L) :-
	length(L, N),
	domain(L, Min, Max),
	restrict_alternates(L),
	labeling([], L).

restrict_alternates([]).
restrict_alternates([_]).

restrict_alternates([E1,E2]) :-
	E1 #< E2 #\/ E1 #> E2.

restrict_alternates([E1,E2,E3|T]) :-
	(E1 #< E2 #/\ E2 #> E3) #\/ (E1 #> E2 #/\ E2 #< E3),
	restrict_alternates([E2,E3|T]).

% Pergunta #13, exame 2015/2016
concelho(x, 120, 410).
concelho(y, 10, 800).
concelho(z, 543, 2387).
concelho(w, 3, 38).
concelho(k, 234, 376).

concelhos(NDias, MaxDist, ConcelhosVisitados, DistTotal, TotalEleitores) :-
	findall(Chave, concelho(Chave, _, _), Chaves),
	findall(Distancia, concelho(_, Distancia, _), Distancias),
	findall(Eleitor, concelho(_, _, Eleitor), Eleitores),

	length(Chaves, NConcelhos),
	length(NumCVisitados, NConcelhos),
	domain(NumCVisitados, 0, 1), % Lista com valores binários, com cada índice apontado para os concelhos.

	Machines = [machine(0, NConcelhos), machine(1, NDias)], % 0: não vai a nenhum concelho, 1: vai a todos.
	findall(task(0, 1, 1, 1, Index), nth1(_, NumCVisitados, Index), Tasks),

	scalar_product(Distancias, NumCVisitados, #=, DistTotal), % Extrai a distância total da opção.
	DistTotal #=< MaxDist,
	scalar_product(Eleitores, NumCVisitados, #=, TotalEleitores), % Extrai o total de eleitores da opção.

	cumulatives(Tasks, Machines, [bound(upper)]),
	labeling([maximize(TotalEleitores)], NumCVisitados),

	findall(Chave, (nth1(I1, NumCVisitados, 1), nth1(I1, Chaves, Chave)), ConcelhosVisitados). % Mapear índices com chaves.

% Pergunta #13, exame ???
attend(FilmList, Goings, Worth) :-
	length(FilmList, NumFilms),
	length(Goings, NumFilms),
	domain(Goings, 0, 1),

	Machines = [machine(0, NumFilms), machine(1, 1)],
	get_film_tasks(FilmList, Goings, Tasks),

	findall(X, nth1(_, FilmList, (_, _, X)), Worths),
	scalar_product(Worths, Goings, #=, Worth),

	cumulatives(Tasks, Machines, [bound(upper)]),
	labeling([maximize(Worth)], Goings).

get_film_tasks([], [], []).
get_film_tasks([(Start, Duration, _)|TF], [HT|TT], Tasks) :-
	get_film_tasks(TF, TT, TempTasks),

	EndTime #= Start + Duration,
	append(TempTasks, [task(Start, Duration, EndTime, 1, HT)], Tasks).

	
