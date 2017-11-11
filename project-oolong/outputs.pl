/**
  @desc Prints the full game board.
*/
print_board(_, [], _) :- print_formatted_line(top), nl, nl.
print_board(Game, [H|T], TableIndex) :-

  length([H|T], MatrixSize),
  TrimSize is MatrixSize - 3,
  trim_tail([H|T], TrimSize, Block), % Divides the board into a smaller 9x3 block.

  print_formatted_line(top), nl,
  print_block(Game, Block, Block, 0, TableIndex, TableIndex, 0),
  NewTableIndex is TableIndex + 3,

  trim_head([H|T], 3, Remain),
  print_board(Game, Remain, NewTableIndex).

/**
  @desc Don't ask.
*/
print_block(_, _, _, 9, _, _, _) :- 
  write('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b'),
  write('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b'),
  write('\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b').

/**
  @desc Prints a 9x3 block, e.g. the full North block (NW, N, NE).
*/
print_block(Game, [O_H|O_T], [H|T], Line0, OriginalTable, TableIndex, SeatIndex) :-
  
  write('|'), 

  Line1 is Line0 + 1,
  Line2 is Line1 + 1,

  nth0(Line0, H, Elem1),
  nth0(Line1, H, Elem2),
  nth0(Line2, H, Elem3),

  print_piece(Game, Elem1, TableIndex, SeatIndex), NewSeatIndex1 is SeatIndex + 1,
  print_piece(Game, Elem2, TableIndex, NewSeatIndex1), NewSeatIndex2 is SeatIndex + 2,
  print_piece(Game, Elem3, TableIndex, NewSeatIndex2), NewSeatIndex3 is SeatIndex + 3,

  write('|'),

  NewLine is Line0 + 3,

  NewTableIndex is TableIndex + 1,

  % TODO: Remove else-if statement.
  (T = [] -> nl, print_formatted_line(medium), nl, Asdf is OriginalTable, print_block(Game, [O_H|O_T], [O_H|O_T], NewLine, OriginalTable, Asdf, NewSeatIndex3);
             print_block(Game, [O_H|O_T], T, Line0, OriginalTable, NewTableIndex, SeatIndex)).

/**
  @desc Prints a formatted pretty line.
*/
print_formatted_line(top) :-
  write(' ---------  ---------  --------- ').

print_formatted_line(medium) :-
  write('|         ||         ||         |').


/**
  @desc Prints a single piece, according to its type.
        If the waiter is present in the tile, the background is colored red.
*/
print_piece(Game, Piece, Table, Seat) :-
  check_waiter(Game, Table, Seat),
  Piece = x,
  ansi_format([fg(black), bg(red)], ' ~w ', ['-']).

print_piece(_, Piece, _, _) :-
  Piece = x,
  ansi_format([fg(black)], ' ~w ', ['-']).

print_piece(Game, Piece, Table, Seat) :-
  check_waiter(Game, Table, Seat),
  Piece = b,
  ansi_format([fg(black), bg(red)], ' ~w ', ["\u25CF"]).

print_piece(_, Piece, _, _) :-
  Piece = b,
  ansi_format([fg(black)], ' ~w ', ["\u25CF"]).

print_piece(Game, Piece, Table, Seat) :-
  check_waiter(Game, Table, Seat),
  Piece = g,
  ansi_format([fg(green), bg(red)], ' ~w ', ["\u25CF"]).

print_piece(_, Piece, _, _) :-
  Piece = g,
  ansi_format([fg(green)], ' ~w ', ["\u25CF"]).

/**
  @desc Checks whether the waiter is standing in the current printing position.
*/
check_waiter(Game, Table, Seat) :-
  get_waiter(Game, Waiter),

  nth0(0, Waiter, WaiterTable),
  nth0(1, Waiter, WaiterSeat),

  Table + 1 =:= WaiterTable,
  Seat + 1 =:= WaiterSeat.

print_next_turn_message(Game) :-
  get_turn(Game, Player),
  Player = 'b',

  ansi_format([fg(black)], 'Make your move, BLACK!\n', []).

print_next_turn_message(Game) :-
  get_turn(Game, Player),
  Player = 'g',

  ansi_format([fg(green)], 'Make your move, GREEN!\n', []).
