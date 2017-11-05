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

count(_, [], 0) :- !.

count(X, [X|T], N) :-
  count(X, T, N2),
  N is N2 + 1.

count(X, [Y|T], N) :- 
  X \= Y, 
  count(X, T, N).

rotate_table(_, _, 0, _).
rotate_table(Table, Orientation, Turns, RotatedTable) :-
  
  Orientation = 'CW',
  UpdatedTurns is Turns - 1,

  nth0(0, RotatedTable, E0), nth0(1, RotatedTable, E1),
  nth0(2, RotatedTable, E2), nth0(3, RotatedTable, E3),
  nth0(4, RotatedTable, E4), nth0(5, RotatedTable, E5),
  nth0(6, RotatedTable, E6), nth0(7, RotatedTable, E7),
  nth0(8, RotatedTable, E8),

  rotate_table(Table, Orientation, UpdatedTurns, [E3, E0, E1, E6, E4, E2, E7, E8, E5]).

rotate_table(Table, Orientation, Turns, RotatedTable) :-
  
  Orientation = 'CCW',
  UpdatedTurns is Turns - 1,

  nth0(0, RotatedTable, E0), nth0(1, RotatedTable, E1),
  nth0(2, RotatedTable, E2), nth0(3, RotatedTable, E3),
  nth0(4, RotatedTable, E4), nth0(5, RotatedTable, E5),
  nth0(6, RotatedTable, E6), nth0(7, RotatedTable, E7),
  nth0(8, RotatedTable, E8),

  rotate_table(Table, Orientation, UpdatedTurns, [E1, E2, E5, E0, E4, E8, E3, E6, E7]).




