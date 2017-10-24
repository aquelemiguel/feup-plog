print_board([]).


print_board([H|T]) :-
  length([H|T], MatrixSize),
  TrimSize is MatrixSize - 3,
  trim_tail([H|T], TrimSize, Block),

  print_block(Block, 0),

  trim_head([H|T], 3, Remain),
  print_board(Remain).

print_block(_, Index0) :-
  NewIndex is Index0 + 3.


print_block([H|T], Index0) :-

  nth0(Index0, H, Elem1),
  Index1 is Index0 + 1,
  nth0(Index1, H, Elem2),
  Index2 is Index0 + 2,
  nth0(Index2, H, Elem3),

  write(Elem1), nl, write(Elem2), nl, write(Elem3), nl, nl,
  %append([Elem1, Elem2, Elem3], Line, Line),

  print_block(T, Index0).
