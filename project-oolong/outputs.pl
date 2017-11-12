:- dynamic current_marker/1.
:- dynamic sidebar_index/1.

/**
  @desc Prints the full game board.
*/
print_board(Game, [H|T], Table) :-
  print_current_player(Game),
  print_scoreboard(Game),

  retractall(sidebar_index(_)),
  assertz(sidebar_index(0)),
  assertz(current_marker(1)),

  print_tabletop(Game, [H|T], Table),

  retractall(sidebar_index(_)),
  retractall(current_marker(_)).

print_current_player(Game) :-
  get_turn(Game, Player),
  Player = b,
  get_full_name(Player, FullPlayerName),

  ansi_format([fg(black)], ' ~w', [FullPlayerName]).

print_current_player(Game) :-
  get_turn(Game, Player),
  Player = g,
  get_full_name(Player, FullPlayerName),

  ansi_format([fg(green)], ' ~w', [FullPlayerName]).

print_sidebar(Game) :-
  
  sidebar_index(SidebarIndex),
  current_marker(MarkerIndex),

  ite(SidebarIndex = 1, write('    This place feels'), true),
  ite(SidebarIndex = 2, write('   kinda empty so here'), true),
  ite(SidebarIndex = 3, write('     are some words.'), true),

  ite(SidebarIndex = 6, ansi_format([fg(green)], '    SPECIAL MARKERS', []), true),
  increment_sidebar_index(SidebarIndex),

  SidebarIndex >= 8, MarkerIndex =< 9,
  get_special(Game, Special),

  nth1(MarkerIndex, Special, Marker),

  ansi_format([fg(black)], '   [~w] ~w', [MarkerIndex, Marker]),
  increment_marker_index(MarkerIndex).

print_sidebar(_).

increment_sidebar_index(Index) :-
  retractall(sidebar_index(_)),
  NewIndex is Index + 1,
  assertz(sidebar_index(NewIndex)).

increment_marker_index(Index) :-
  retractall(current_marker(_)),
  NewIndex is Index + 1,
  assertz(current_marker(NewIndex)).

print_scoreboard(Game) :-
  get_tracker(Game, Tracker),
  count(b, Tracker, CountB), count(g, Tracker, CountG),
  ansi_format([fg(black)], '                       ~w:', [CountB]),
  ansi_format([fg(green)], '~w\n', [CountG]).

print_tabletop(_, [], _) :- print_formatted_line(top), nl, nl.

print_tabletop(Game, [H|T], TableIndex) :-

  length([H|T], MatrixSize),
  TrimSize is MatrixSize - 3,
  trim_tail([H|T], TrimSize, Block), % Divides the board into a smaller 9x3 block.

  print_formatted_line(top), nl,
  print_block(Game, Block, Block, 0, TableIndex, TableIndex, 0),
  NewTableIndex is TableIndex + 3,

  trim_head([H|T], 3, Remain),
  print_tabletop(Game, Remain, NewTableIndex).

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
  (T = [] -> print_sidebar(Game), nl, print_formatted_line(Game, medium), nl, Asdf is OriginalTable, print_block(Game, [O_H|O_T], [O_H|O_T], NewLine, OriginalTable, Asdf, NewSeatIndex3);
            print_block(Game, [O_H|O_T], T, Line0, OriginalTable, NewTableIndex, SeatIndex)).

/**
  @desc Prints a formatted pretty line.
*/
print_formatted_line(top) :-
  write(' ---------  ---------  --------- ').

print_formatted_line(Game, medium) :-
  write('|         ||         ||         |'), print_sidebar(Game).


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