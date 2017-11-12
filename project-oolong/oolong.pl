:- use_module(library(lists)).
:- use_module(library(random)).

:- include('game.pl').
:- include('menus.pl').
:- include('outputs.pl').
:- include('ai.pl').
:- include('utilities.pl').
:- include('settings.pl').

oolong :- main_menu. % Entry function call.

/**
  @desc Main game loop for the Player vs AI gamemode.
*/
game_loop(Game) :-
  get_gamemode(Game, Mode),
  get_bot_difficulty(Game, BotDifficulty),

  Mode = 1,
  BotDifficulty = easy,

  clear_console,
  get_board(Game, Board),
  print_board(Game, Board, 0),

  play_turn(Game, UpdatedGame),
  get_board(UpdatedGame, NewBoard),
  print_board(UpdatedGame, NewBoard, 0),

  write('Bot is thinking...'), nl,

  sleep_time(SleepTime), sleep(SleepTime),
  bot_play_turn_easy(UpdatedGame, UpdatedGame2),
  switch_turn(UpdatedGame2, FinalGame),

  game_loop(FinalGame).

game_loop(Game) :-
  get_gamemode(Game, Mode),
  get_bot_difficulty(Game, BotDifficulty),

  Mode = 1,
  BotDifficulty = normal,

  clear_console,
  get_board(Game, Board),
  print_board(Game, Board, 0),

  play_turn(Game, UpdatedGame),
  get_board(UpdatedGame, NewBoard),
  print_board(UpdatedGame, NewBoard, 0),

  write('Bot is thinking...'), nl,
  sleep_time(SleepTime), sleep(SleepTime),
  bot_play_turn_normal(UpdatedGame, UpdatedGame2),
  switch_turn(UpdatedGame2, FinalGame),


  game_loop(FinalGame).

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
  get_bot_difficulty(Game, BotDifficulty),

  Mode = 3,
  BotDifficulty = easy,

  sleep_time(SleepTime), sleep(SleepTime),
  clear_console,
  get_board(Game, Board),
  print_board(Game, Board, 0),

  bot_play_turn_easy(Game, TempGame),
  switch_turn(TempGame, UpdatedGame),

  game_loop(UpdatedGame).

game_loop(Game) :-

  get_gamemode(Game, Mode),
  get_bot_difficulty(Game, BotDifficulty),

  Mode = 3,
  BotDifficulty = normal,

  sleep_time(SleepTime), sleep(SleepTime),
  clear_console,
  get_board(Game, Board),
  print_board(Game, Board, 0),

  bot_play_turn_normal(Game, TempGame),
  switch_turn(TempGame, UpdatedGame),

  game_loop(UpdatedGame).

game_loop(Game) :- game_loop(Game).

/**
  @desc Prompts next position from current player.
*/
play_turn(Game, UpdatedGame) :-

  get_waiter(Game, Waiter),
  nth0(0, Waiter, CurrentTableIndex),

  check_table_is_full(Game, CurrentTableIndex),

  table_full_menu(Game, TableIndex, SeatIndex),

  update_waiter_table(Game, TableIndex, NewGame),


  validate_move(NewGame, SeatIndex),
  place_piece(NewGame, SeatIndex, UpdatedGame2),

  trigger_special(UpdatedGame2, TableIndex, UpdatedGame3),

  get_board(UpdatedGame3, Board2),
  nth1(TableIndex, Board2, Table2),

  check_majority(UpdatedGame3, Table2, TempGame),

  switch_turn(TempGame, UpdatedGame),
  check_win(UpdatedGame),
  main_menu.


play_turn(Game, UpdatedGame) :-

  read(SeatIndex),

  validate_move(Game, SeatIndex),
  place_piece(Game, SeatIndex, UpdatedGame2),

  get_waiter(Game, Waiter),
  nth0(0, Waiter, TableIndex),

  trigger_special(UpdatedGame2, TableIndex, UpdatedGame3),

  get_board(UpdatedGame3, Board2),
  nth1(TableIndex, Board2, Table2),

  check_majority(UpdatedGame3, Table2, TempGame),

  switch_turn(TempGame, UpdatedGame),
  check_win(UpdatedGame),
  main_menu.

play_turn(Game, UpdatedGame) :- play_turn(Game, UpdatedGame).

/**
  @desc Checks whether the inputted seat is either already occupied or out of bounds.
*/
validate_move(Game, SeatIndex) :-
  SeatIndex >= 1, SeatIndex =< 9,

  get_board(Game, Board),
  get_waiter(Game, Waiter),

  nth0(0, Waiter, TableIndex),

  nth1(TableIndex, Board, Table),
  nth1(SeatIndex, Table, Seat),

  Seat = x.

validate_move(_, SeatIndex) :-
  (SeatIndex < 1; SeatIndex > 9),
  write('Seat out of bounds!'), fail.

validate_move(Game, SeatIndex) :-

  get_board(Game, Board),
  get_waiter(Game, Waiter),

  nth0(0, Waiter, TableIndex),

  nth1(TableIndex, Board, Table),
  nth1(SeatIndex, Table, Seat),

  Seat \= x,
  write('Seat already occupied!'), fail.

validate_move(Game, SeatIndex) :-

  get_board(Game, Board),

  nth1(SeatIndex, Board, Table),
  count(x, Table, CountEmpty),

  CountEmpty = 0,
  write('Table already full!'), fail.

/**
  @desc Triggers the special markers.
*/

trigger_special(Game, TableIndex, UpdatedGame) :-

  get_special(Game, Special),
  nth1(TableIndex, Special, Marker),
  handle_specific_special(Game, TableIndex, Marker, UpdatedGame).

trigger_special(Game, _, UpdatedGame) :- append(Game, [], UpdatedGame). % No special marker was triggered.

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
  replace(Game, 0, UpdatedBoard, TempGame),

  unbind_marker_from_table(TempGame, LessTableIndex, UpdatedGame).

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

  LessTableIndex is TableIndex - 1,
  LessTableIndex1 is TableIndex1 - 1,
  LessTableIndex2 is TableIndex2 - 1,

  % Switches the provided tables.
  replace(Board, LessTableIndex1, Table2, TempBoard),
  replace(TempBoard, LessTableIndex2, Table1, FinalBoard),
  replace(Game, 0, FinalBoard, TempGame),

  unbind_marker_from_table(TempGame, LessTableIndex, UpdatedGame),

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

  LessTableIndex is TableIndex - 1,
  LessTableIndex1 is TableIndex1 - 1,
  LessTableIndex2 is TableIndex2 - 1,

  % Switches the provided tables.
  replace(Board, LessTableIndex1, Table2, TempBoard),
  replace(TempBoard, LessTableIndex2, Table1, FinalBoard),

  replace(Game, 0, FinalBoard, TempGame),

  unbind_marker_from_table(TempGame, LessTableIndex, UpdatedGame2),

  get_tracker(UpdatedGame2, Tracker),
  get_turn(UpdatedGame2, Player),
  replace(Tracker, LessTableIndex2, Player, TempTracker),
  replace(TempTracker, LessTableIndex1, x, FinalTracker),
  replace(UpdatedGame2, 1, FinalTracker, UpdatedGame),

  get_tracker(UpdatedGame, YayTracker),

  write('Este e o tracker pos switch: '), write(YayTracker),nl,

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

  % Retrieves the tables where the pieces are going to be switched
  menu_move_black(Game, TableIndex1, SeatIndex1, TableIndex2, SeatIndex2),

  nth1(TableIndex1, Board, Table1),
  nth1(TableIndex2, Board, Table2),

  LessTableIndex1 is TableIndex1 - 1,
  LessTableIndex2 is TableIndex2 - 1,

  %Updates the tables

  SeatReplace is SeatIndex1 - 1,
  SeatReplace2 is SeatIndex2 - 1,

  replace(Table1, SeatReplace, x, NewTable),
  replace(Board, LessTableIndex1, NewTable, NewBoard),

  replace(Table2, SeatReplace2, b, NewTable2),
  replace(NewBoard, LessTableIndex2, NewTable2, FinalBoard),

  replace(Game, 0, FinalBoard, TempGame),
  check_majority(TempGame, NewTable2, TempGame2),

  Asdf is TableIndex - 1,
  unbind_marker_from_table(TempGame2, Asdf, UpdatedGame),

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

  % Retrieves the tables where the pieces are going to be switched
  menu_move_green(Game, TableIndex1, SeatIndex1, TableIndex2, SeatIndex2),

  nth1(TableIndex1, Board, Table1),
  nth1(TableIndex2, Board, Table2),

  LessTableIndex1 is TableIndex1 - 1,
  LessTableIndex2 is TableIndex2 - 1,

  %Updates the tables

  SeatReplace is SeatIndex1 - 1,
  SeatReplace2 is SeatIndex2 - 1,

  replace(Table1, SeatReplace, x, NewTable),
  replace(Board, LessTableIndex1, NewTable, NewBoard),

  replace(Table2, SeatReplace2, g, NewTable2),
  replace(NewBoard, LessTableIndex2, NewTable2, FinalBoard),

  replace(Game, 0, FinalBoard, TempGame),

  Asdf is TableIndex - 1,
  unbind_marker_from_table(TempGame, Asdf, UpdatedGame2),

  check_majority(UpdatedGame2, NewTable2, UpdatedGame),

  write('Piece switched!'), nl.

/**
  @desc WAITERBLACK special marker handler.
        Triggered with x matching tokens.
*/
handle_specific_special(Game, TableIndex, Marker, UpdatedGame) :-
  get_board(Game, Board),
  nth1(TableIndex, Board, Table),

  Marker = 'WaiterBlack',
  count(b, Table, CountB),
  CountB = 5,

  move_black_waiter(Game, TableIndex2),

  update_waiter(Game, TableIndex, TempGame),
  update_waiter(TempGame, TableIndex2, TempGame2),
  unbind_marker_from_table(TempGame2, TableIndex, UpdatedGame).

handle_specific_special(Game, TableIndex, Marker, UpdatedGame) :-
  get_board(Game, Board),
  nth1(TableIndex, Board, Table),

  Marker = 'WaiterGreen',
  count(g, Table, CountG),
  CountG = 5,

  move_green_waiter(Game, TableIndex2),

  update_waiter(Game, TableIndex, TempGame),
  update_waiter(TempGame, TableIndex2, TempGame2),
  unbind_marker_from_table(TempGame2, TableIndex, UpdatedGame).

handle_specific_special(Game, _, _, UpdatedGame) :-
  append(Game, [], UpdatedGame).

/**
  @desc Used when a marker is used or if it triggers but cannot be executed.
        e.g. SWAPMIXED is triggered but there aren't any claimed tables.
*/
unbind_marker_from_table(Game, TableIndex, UpdatedGame) :-

  get_special(Game, Special),
  replace(Special, TableIndex, 'Empty', NewSpecial),
  replace(Game, 2, NewSpecial, UpdatedGame).
