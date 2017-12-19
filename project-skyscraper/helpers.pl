replace([_|T], 0, New, [New|T]).

replace([H|T], Index, New, [H|R]) :-
	I1 is Index - 1,
	replace(T, I1, New, R).

flatten([], []) :- !.

flatten([L|Ls], FlatL) :-
	!, flatten(L, NewL), flatten(Ls, NewLs),
	append(NewL, NewLs, FlatL).

flatten(L, [L]).

clear_console :-
	clear_console(40), !.

clear_console(0).

clear_console(N) :-
	nl, N1 is N - 1, clear_console(N1).