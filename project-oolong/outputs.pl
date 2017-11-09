/**
  @desc Prints the full game board.
*/
print_board(_, [], _).
print_board(Game, [H|T], TableIndex) :-

  length([H|T], MatrixSize),
  TrimSize is MatrixSize - 3,
  trim_tail([H|T], TrimSize, Block), % Divides the board into a smaller 9x3 block.

  print_block(Game, Block, Block, 0, TableIndex, 0),
  NewTableIndex is TableIndex + 3,

  trim_head([H|T], 3, Remain),
  print_board(Game, Remain, NewTableIndex).

/**
  Prints a 9x3 block, e.g. the full North block (NW, N, NE).
*/
print_block(_, _, _, 9, _, _).
print_block(Game, [O_H|O_T], [H|T], Line0, TableIndex, SeatIndex) :-

  Line1 is Line0 + 1,
  Line2 is Line1 + 1,

  nth0(Line0, H, Elem1),
  nth0(Line1, H, Elem2),
  nth0(Line2, H, Elem3),

  print_piece(Game, Elem1, TableIndex, SeatIndex), NewSeatIndex1 is SeatIndex + 1,
  print_piece(Game, Elem2, TableIndex, NewSeatIndex1), NewSeatIndex2 is SeatIndex + 2,
  print_piece(Game, Elem3, TableIndex, NewSeatIndex2), NewSeatIndex3 is SeatIndex + 3,

  NewLine is Line0 + 3,

  NewTableIndex is TableIndex + 1,

  % TODO: Remove else-if statement.
  (T = [] -> nl, nl, print_block(Game, [O_H|O_T], [O_H|O_T], NewLine, NewTableIndex, 0);
             print_block(Game, [O_H|O_T], T, Line0, TableIndex, NewSeatIndex3)).

/**
  @desc Prints a single piece, according to its type.
        If the waiter is present in the tile, the background is colored red.
*/
print_piece(Game, Piece, Table, Seat) :-

  check_waiter(Game, Table, Seat),
  %write(Table), write('.'), write(Seat), nl,
  Piece = x,
  ansi_format([bg(red)], ' - ', []).

print_piece(Game, Piece, Table, Seat) :-
  Piece = x,
  ansi_format([fg(black)], ' - ', []).

print_piece(Game, Piece, Table, Seat) :-
  check_waiter(Game, Table, Seat),
  Piece = b,
  ansi_format([fg(black), bg(red)], ' B ', []).

print_piece(Game, Piece, Table, Seat) :-
  Piece = b,
  ansi_format([fg(black)], ' B ', []).

print_piece(Game, Piece, Table, Seat) :-
  check_waiter(Game, Table, Seat),
  Piece = g,
  ansi_format([fg(green), bg(red)], ' G ', []).

print_piece(Game, Piece, Table, Seat) :-
  Piece = g,
  ansi_format([fg(green)], ' G ', []).

/**
  @desc Checks whether the waiter is standing in the current printing position.
*/
check_waiter(Game, Table, Seat) :-
  %write('Table:  '), write(Table), nl,
  %write('Seat:  '), write(Seat), nl,
  get_waiter(Game, Waiter),

  nth0(0, Waiter, WaiterTable),
  nth0(1, Waiter, WaiterSeat),

  write(Table), write(Seat),

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
