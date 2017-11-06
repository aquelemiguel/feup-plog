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

/**
  @desc Checks whether the table is still unclaimed (majority not reached by one player).
        If it fails, a message is printed.
*/
check_unclaimed_table(Game, TableIndex) :-
  get_board(Game, Board),
  nth1(TableIndex, Board, Table),

  count(b, ActualTable1, CountB), count(g, ActualTable1, CountG),
  CountB < 5, CountG < 5.

check_unclaimed_table(Game, TableIndex) :-
  write('Selected table has already been claimed!'), nl, fail.

/**
  @desc Checks whether the table has already been claimed (majority reached by one of the player).
        If it fails, a message is printed.
*/
check_claimed_table(Game, TableIndex) :-
  get_board(Game, Board),
  nth1(TableIndex, Board, Table),

  count(b, ActualTable1, CountB), count(g, ActualTable1, CountG),
  (CountB >= 5; CountG >= 5).

check_claimed_table(Game, TableIndex) :-
  write('Selected table is still unclaimed!'), nl, fail.

/**
  @desc Checks whether there's a table that is claimed (majority reached by one of the player).
        If no tables are found, the predicate fails.
*/
check_exists_any_claimed(_, 10) :-
  write('No claimed tables were found!'), nl, fail.

check_exists_any_claimed(Game, Index) :-
  get_board(Game, Board),
  nth1(Index, Board, Table),

  count(b, Table, CountB), count(g, Table, CountG),
  (CountB >= 5; CountG >= 5).

check_exists_any_claimed(Game, Index) :-
  NewIndex is Index + 1,
  check_exists_any_claimed(Game, NewIndex).

/**
  @desc Checks whether there's a table that is unclaimed.
        If no tables are found, the predicate fails.
*/
check_exists_any_unclaimed(_, 10) :-
  write('No unclaimed tables were found!'), nl, fail.

check_exists_any_unclaimed(Game, Index) :-
  get_board(Game, Board),
  nth1(Index, Board, Table),

  count(b, Table, CountB), count(g, Table, CountG),
  (CountB < 5; CountG < 5).

check_exists_any_unclaimed(Game, Index) :-
  NewIndex is Index + 1,
  check_exists_any_claimed(Game, NewIndex).

/**
  @desc Checks whether the inputted index falls within the 1-9 range.
*/
check_index_out_of_bounds(Index) :-
  Index > 0, Index < 10.

check_index_out_of_bounds(Index) :-
  write('Index out of bounds!'), nl, fail.





