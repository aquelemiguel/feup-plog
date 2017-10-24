clear_console :-
  clear_console(40), !.

clear_console(0).

clear_console(N) :-
  nl, N1 is N - 1, clear_console(N1).

replace([_|T], 0, New, [New|T]).
replace([H|T], Index, New, [H|R]) :-
  I1 is Index - 1,
  replace(T, I1, New, R).

trim_head(L,N,S) :- length(P,N), append(P,S,L).
trim_tail(L,N,S) :- reverse(L,R), length(P,N), append(P,K,R), reverse(K,S).
