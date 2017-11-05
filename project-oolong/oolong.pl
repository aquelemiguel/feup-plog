:- use_module(library(lists)).

:- include('game.pl').
:- include('menus.pl').
:- include('outputs.pl').
:- include('utilities.pl').

oolong :- main_menu. % Entry function call.

start_game(Game) :-
  get_board(Game, Board),
  print_board(Game, Board, 0),
  get_gamemode(Game, Mode), Mode = 1,
  play_turn(Game, UpdatedGame),
  start_game(UpdatedGame).

/**
  @desc Prompts next position from current player.
*/
play_turn(Game, UpdatedGame) :-
  read(SeatIndex),

  validate_move(Game, SeatIndex),
  write('Play validated!'), nl,
  place_piece(Game, SeatIndex, UpdatedGame),

  get_board(UpdatedGame, Board),
  get_table_index(Game, TableIndex),
  nth1(TableIndex, Board, Table),

  trigger_special(UpdatedGame, TableIndex, UpdatedGame2),

  check_majority(UpdatedGame2, Table, UpdatedGame3),
  check_win(UpdatedGame3).

play_turn(Game, UpdatedGame) :- play_turn(Game, UpdatedGame).

/**
  @desc Checks whether the inputted seat is either already occupied or out of bounds.
*/
validate_move(Game, SeatIndex) :-
  SeatIndex >= 1, SeatIndex =< 9,

  get_board(Game, Board),
  get_table_index(Game, TableIndex),

  nth1(TableIndex, Board, Table),
  nth1(SeatIndex, Table, Seat),

  Seat = x.

validate_move(Game, SeatIndex) :-
  (SeatIndex < 1; SeatIndex > 9),
  write('Seat out of bounds!'), fail.

validate_move(Game, SeatIndex) :-

  get_board(Game, Board),
  get_table_index(Game, TableIndex),

  nth1(TableIndex, Board, Table),
  nth1(SeatIndex, Table, Seat),

  Seat \= x,
  write('Seat already occupied!'), fail.

/**
  @desc Triggers the special markers.
*/
trigger_special(Game, TableIndex, UpdatedGame) :-

  get_board(Game, Board),
  nth1(TableIndex, Board, Table),
  get_special(Game, Special),

  TableIndex = 5, % Ignores the center table.
  write('Center has no special markers assigned.'), nl.

trigger_special(Game, TableIndex, UpdatedGame) :-

  get_board(Game, Board),
  nth1(TableIndex, Board, Table),
  get_special(Game, Special),

  TableIndex < 5,
  nth1(TableIndex, Special, Marker),

  handle_specific_special(Game, TableIndex, Marker, UpdatedGame).

trigger_special(Game, TableIndex, UpdatedGame) :-

  get_board(Game, Board),
  nth1(TableIndex, Board, Table),
  get_special(Game, Special),

  TableIndex > 5,
  DecrementedTableIndex is TableIndex - 1,
  nth1(DecrementedTableIndex, Special, Marker),

  write('The index '), write(TableIndex), write(' has the marker '), write(Marker), write('.'), nl,
  handle_specific_special(Game, TableIndex, Marker, UpdatedGame).

trigger_special(Game, TableIndex, UpdatedGame). % No special marker was triggered.

/**
  @desc ROTATE special marker handler.
        Allows triggering player to rotate the targeted tile to any orientation (waiter rotates with tile).
        Triggered with 4 matching tokens.
*/
handle_specific_special(Game, TableIndex, Marker, UpdatedGame) :-

  get_board(Game, Board),
  nth1(TableIndex, Board, Table),

  (Marker = 'Rotate1'; Marker = 'Rotate2'),
  count(b, Table, CountB),
  CountB = 4,

  menu_rotate_tile(Orientation, Turns),

  rotate_table(Table, Orientation, Turns, RotatedTable),
  write('Table rotated!'), nl,

  LessTableIndex is TableIndex - 1,
  replace(Board, TableIndex, RotatedTable, UpdatedBoard),
  replace(Game, 0, UpdatedBoard, UpdatedGame).

handle_specific_special(Game, TableIndex, Marker, UpdatedGame) :-

  get_board(Game, Board),
  nth1(TableIndex, Board, Table),

  (Marker = 'Rotate1'; Marker = 'Rotate2'),
  count(g, Table, CountG),
  CountG = 4,

  menu_rotate_tile(Orientation, Turns),

  rotate_table(Table, Orientation, Turns, RotatedTable),
  write('Table rotated!'), nl,

  LessTableIndex is TableIndex - 1,
  replace(Board, TableIndex, RotatedTable, UpdatedBoard),
  replace(Game, 0, UpdatedBoard, UpdatedGame).

/**
  @desc SWAPUNCLAIMED special marker handler.
        Allows triggering player to swap position of any two unclaimed tiles.
        Triggered with 4 matching tokens.
*/
handle_specific_special(Game, TableIndex, Marker, UpdatedGame) :-

  get_board(Game, Board),
  nth1(TableIndex, Board, Table),

  Marker = 'SwapUnclaimed',
  count(b, Table, CountB),
  count(g, Table, CountG),
  (CountB = 4; CountG = 4),

  menu_swap_unclaimed(Game, TableIndex1, TableIndex2),
  nth1(TableIndex1, Board, Table1),
  nth1(TableIndex2, Board, Table2),

  LessTableIndex1 is TableIndex1 - 1,
  LessTableIndex2 is TableIndex2 - 1,

  % Switches the provided tables.
  replace(Board, LessTableIndex1, Table2, TempBoard),
  replace(TempBoard, LessTableIndex2, Table1, FinalBoard),
  replace(Game, 0, FinalBoard, UpdatedGame),

  write('Tables switched!'), nl.

/**
  @desc SWAPMIXED special marker handler.
        Allows triggering player to swap position of any claimed tile with any unclaimed tile.
        Triggered with 5 matching tokens.
*/
handle_specific_special(Game, TableIndex, Marker, UpdatedGame) :-
  
  get_board(Game, Board),
  nth1(TableIndex, Board, Table),

  Marker = 'SwapMixed',
  count(b, Table, CountB),
  count(g, Table, CountG),
  (CountB = 4; CountG = 4),

  menu_swap_unclaimed(Game, TableIndex1, TableIndex2),
  nth1(TableIndex1, Board, Table1),
  nth1(TableIndex2, Board, Table2),

  LessTableIndex1 is TableIndex1 - 1,
  LessTableIndex2 is TableIndex2 - 1,

  % Switches the provided tables.
  replace(Board, LessTableIndex1, Table2, TempBoard),
  replace(TempBoard, LessTableIndex2, Table1, FinalBoard),
  replace(Game, 0, FinalBoard, UpdatedGame),

  write('Tables switched!'), nl.







