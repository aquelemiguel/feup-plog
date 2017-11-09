:- use_module(library(lists)).

:- include('game.pl').
:- include('menus.pl').
:- include('outputs.pl').
:- include('ai.pl').
:- include('utilities.pl').

oolong :- main_menu. % Entry function call.


/**
  @desc Main game loop for the Player vs AI gamemode.
*/
game_loop(Game) :-
  get_gamemode(Game, Mode),
  Mode = 1,

  clear_console,
  get_board(Game, Board),
  print_board(Game, Board, 0),

  play_turn(Game, UpdatedGame),
  get_board(UpdatedGame, NewBoard),
  print_board(UpdatedGame, NewBoard, 0),

  write('Bot is thinking...'), nl,
  sleep(1),
  bot_play_turn_easy(UpdatedGame, UpdatedGame2),

  game_loop(UpdatedGame2).

/**
  @desc Main game loop for the Player vs Player gamemode.
*/
game_loop(Game) :-
  get_gamemode(Game, Mode),
  Mode = 2,

  clear_console,
  get_board(Game, Board),
  print_board(Game, Board, 0),
  play_turn(Game, UpdatedGame),
  game_loop(UpdatedGame).

/**
  @desc Main game loop for the AI vs AI gamemode.
*/
game_loop(Game) :-
  get_gamemode(Game, Mode),
  Mode = 3,

  sleep(1),
  clear_console,
  get_board(Game, Board),
  print_board(Game, Board, 0),
  
  bot_play_turn_easy(Game, UpdatedGame),

  game_loop(UpdatedGame).

/**
  @desc Prompts next position from current player.
*/
play_turn(Game, UpdatedGame) :-

  print_next_turn_message(Game),
  read(SeatIndex),

  validate_move(Game, SeatIndex),
  place_piece(Game, SeatIndex, UpdatedGame2),

  get_board(UpdatedGame2, Board),
  get_table_index(Game, TableIndex),
  nth1(TableIndex, Board, Table),

  trigger_special(UpdatedGame2, TableIndex, UpdatedGame3),

  check_majority(UpdatedGame3, Table, UpdatedGame),
  check_win(UpdatedGame).

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

validate_move(Game, SeatIndex) :-

  get_board(Game, Board),
  get_table_index(Game, TableIndex),

  nth1(SeatIndex, Board, Table),
  count(x, Table, CountEmpty),

  CountEmpty = 0,
  write('Table already full!'), fail.

/**
  @desc Triggers the special markers.
*/
trigger_special(Game, TableIndex, UpdatedGame) :-

  get_board(Game, Board),
  nth1(TableIndex, Board, Table),
  get_special(Game, Special),

  TableIndex = 5, % Ignores the center table.

  append(Game, [], UpdatedGame),
  write('Center has no special markers assigned.'), nl.

trigger_special(Game, TableIndex, UpdatedGame) :-

  get_board(Game, Board),
  get_special(Game, Special),

  TableIndex < 5,
  nth1(TableIndex, Special, Marker),

  write('The index '), write(TableIndex), write(' has the marker '), write(Marker), write('.'), nl,
  handle_specific_special(Game, TableIndex, Marker, UpdatedGame).

trigger_special(Game, TableIndex, UpdatedGame) :-

  get_board(Game, Board),
  get_special(Game, Special),

  TableIndex > 5,
  DecrementedTableIndex is TableIndex - 1,
  nth1(DecrementedTableIndex, Special, Marker),

  write('The index '), write(TableIndex), write(' has the marker '), write(Marker), write('.'), nl,
  handle_specific_special(Game, TableIndex, Marker, UpdatedGame).

trigger_special(Game, TableIndex, UpdatedGame) :- append(Game, [], UpdatedGame). % No special marker was triggered.

/**
  @desc ROTATE special marker handler.
        Allows triggering player to rotate the targeted tile to any orientation (waiter rotates with tile).
        Triggered with 4 matching tokens.
*/
handle_specific_special(Game, TableIndex, Marker, UpdatedGame) :-

  get_board(Game, Board),
  nth1(TableIndex, Board, Table),

  (Marker = 'Rotate1'; Marker = 'Rotate2'),
  count(b, Table, CountB), count(g, Table, CountG),
  (CountB = 4; CountG = 4),

  menu_rotate_tile(Game, Orientation, Turns),

  rotate_table(Table, Orientation, Turns, RotatedTable),
  write('Table rotated!'), nl,

  LessTableIndex is TableIndex - 1,

  replace(Board, LessTableIndex, RotatedTable, UpdatedBoard),
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

  check_exists_any_unclaimed(Game, 1),

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
  (CountB = 5; CountG = 5),

  check_exists_any_claimed(Game, 1), % If there's no claimed table to swap, this shouldn't run.
  check_exists_any_unclaimed(Game, 1), % If there's no unclaimed table to swap, this shouldn't run.

  menu_swap_mixed(Game, TableIndex1, TableIndex2),
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
  @desc MOVEBLACK special marker handler.
        Allows black player to move one of their tokens from any unclaimed tile to any other unclaimed tile.
        Triggered with 3 matching tokens.
*/
handle_specific_special(Game, TableIndex, Marker, UpdatedGame) :-

  get_board(Game, Board),
  nth1(TableIndex, Board, Table),

  Marker = 'MoveBlack',
  count(b, Table, CountB),
  CountB = 3,

  menu_move_black(Game, TableIndex1, TableIndex2),
  nth1(TableIndex1, Board, Table1),
  nth1(TableIndex2, Board, Table2),

  LessTableIndex1 is TableIndex1 - 1,
  LessTableIndex2 is TableIndex2 - 1,

  % Switches the provided tables.
  get_tracker(Game, Tracker),
  nth1(TableIndex1, Tracker, Majority),
  Majority = x,

  get_tracker(Game, AnotherTracker),
  nth1(TableIndex1, AnotherTracker, Majority2),
  Majority2 = x,

  menu_move_black_piece(Game, SeatIndex1, SeatIndex2),

  nth1(SeatIndex1, Table1, Seat),
  Seat = b,

  nth1(SeatIndex2, Table2, Seat2),
  Seat2 = x,

  SeatReplace is SeatIndex1 - 1,
  SeatReplace2 is SeatIndex2 - 1,


  replace(Table1, SeatReplace, x, NewTable),
  replace(Board, LessTableIndex1, NewTable, NewBoard),

  replace(Table2, SeatReplace2, b, NewTable2),
  replace(NewBoard, LessTableIndex2, NewTable2, FinalBoard),

  replace(Game, 0, FinalBoard, UpdatedGame),


  write('Piece switched!'), nl.

/**
  @desc MOVEGREEN special marker handler.
        Allows green player to move one of their tokens from any unclaimed tile to any other unclaimed tile.
        Triggered with 3 matching tokens.
*/
handle_specific_special(Game, TableIndex, Marker, UpdatedGame) :-

  get_board(Game, Board),
  nth1(TableIndex, Board, Table),

  Marker = 'MoveGreen',
  count(g, Table, CountG),
  CountG = 3,

  %Retrieves the tables where the pieces are going to be switched
  menu_move_green(Game, TableIndex1, TableIndex2),
  nth1(TableIndex1, Board, Table1),
  nth1(TableIndex2, Board, Table2),

  LessTableIndex1 is TableIndex1 - 1,
  LessTableIndex2 is TableIndex2 - 1,

      % Checks whether the tables are unclaimed or not
  get_tracker(Game, Tracker),
  nth1(TableIndex1, Tracker, Majority),
  Majority = x,

  get_tracker(Game, AnotherTracker),
  nth1(TableIndex1, AnotherTracker, Majority2),
  Majority2 = x,

  % Retrieves the seat indexes of the pieces

  menu_move_green_piece(Game, SeatIndex1, SeatIndex2),
  nth1(SeatIndex1, Table1, Seat),
  Seat = g,

  nth1(SeatIndex2, Table2, Seat2),
  Seat2 = x,

  %Updates the tables

  SeatReplace is SeatIndex1 - 1,
  SeatReplace2 is SeatIndex2 - 1,

  replace(Table1, SeatReplace, x, NewTable),
  replace(Board, LessTableIndex1, NewTable, NewBoard),

  replace(Table2, SeatReplace2, g, NewTable2),
  replace(NewBoard, LessTableIndex2, NewTable2, FinalBoard),



  replace(Game, 0, FinalBoard, UpdatedGame),

  write('Piece switched!'), nl.

handle_specific_special(Game, _, _, UpdatedGame) :-
  append(Game, [], UpdatedGame).
