/**
  @desc Prints the full game board.
*/
print_board([]).
print_board([H|T]) :-

  length([H|T], MatrixSize),
  TrimSize is MatrixSize - 3,
  trim_tail([H|T], TrimSize, Block),

  print_block(Block, Block, 0),

  trim_head([H|T], 3, Remain),
  print_board(Remain).

/**
  @desc Prints a 9x3 block, e.g. the full North block (NW, N, NE).
*/
print_block(_, _, 9).
print_block([O_H|O_T], [H|T], Line0) :-

  Line1 is Line0 + 1,
  Line2 is Line1 + 1,

  nth0(Line0, H, Elem1),
  nth0(Line1, H, Elem2),
  nth0(Line2, H, Elem3),

  write(Elem1), write(' '), write(Elem2), write(' '), write(Elem3), write(' '),

  NewLine is Line0 + 3,

  % TODO: Remove else-if statement.
  (T = [] -> write('\n'), print_block([O_H|O_T], [O_H|O_T], NewLine); print_block([O_H|O_T], T, Line0)).

