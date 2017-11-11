init_game(Game, GameMode, BotDifficulty) :-
  empty_board(Board),

  special_actions(Special),

  random_permutation(Special, ShuffledSpecial),

  majority_tracker(Tracker),

  Game = [Board, Tracker, ShuffledSpecial, b, 5, [5,5], GameMode, BotDifficulty],
  game_loop(Game).

% Game class getters.
get_board(Game, Board) :-
  nth0(0, Game, Board).

get_tracker(Game, Tracker) :-
  nth0(1, Game, Tracker).

get_special(Game, Special) :-
  nth0(2, Game, Special).

get_turn(Game, Player) :-
  nth0(3, Game, Player).

get_table_index(Game, TableIndex) :-
  nth0(4, Game, TableIndex).

get_waiter(Game, Waiter) :-
  nth0(5, Game, Waiter).

get_gamemode(Game, GameMode) :-
  nth0(6, Game, GameMode).

get_table(Game, Index, Table) :-
  get_board(Game, Board),
  nth0(Index, Board, Table).

get_bot_difficulty(Game, Difficulty) :-
  nth0(7, Game, Difficulty).

get_opponent(b, g).
get_opponent(g, b).

/**
  @desc Places the current player's piece on the provided seat.
*/
place_piece(Game, SeatIndex, UpdatedGame) :-
  get_board(Game, Board),
  get_table_index(Game, TableIndex),
  get_turn(Game, Player),

  nth1(TableIndex, Board, Table),

  TableTempIndex is TableIndex - 1,
  SeatTempIndex is SeatIndex - 1,

  replace(Table, SeatTempIndex, Player, NewTable),
  replace(Board, TableTempIndex, NewTable, NewBoard),

  update_waiter(Game, SeatIndex, WaiterFixed),

  replace(WaiterFixed, 0, NewBoard, TempGame),
  switch_turn(TempGame, AnotherTemp),

  % TODO: Separate the SeatIndex switch from this predicate.
  replace(AnotherTemp, 4, SeatIndex, UpdatedGame).

/**
  @desc Determines whether a player has filled 5 out of 9 seats on a table, thus claiming majority on it.
*/
check_majority(Game, Table, UpdatedGame) :-
  count(b, Table, CountB),
  CountB >= 5,
  get_table_index(Game, TableIndex),
  add_to_tracker(Game, b, TableIndex, UpdatedGame).

check_majority(Game, Table, UpdatedGame) :-
  count(g, Table, CountG),
  CountG >= 5,
  get_table_index(Game, TableIndex),
  add_to_tracker(Game, g, TableIndex, UpdatedGame).

check_majority(Game, Table, UpdatedGame) :-
  append(Game, [], UpdatedGame). % Copies the unaltered game class to UpdatedGame so check_win functions correctly.

/**
  @desc Determines whether a player has filled 5 out of 9 tables, thus winning the game.
*/
check_win(Game) :-
  get_tracker(Game, Tracker),
  count(b, Tracker, CountB),
  CountB >= 5,
  write('Black wins!').

check_win(Game) :-
  get_tracker(Game, Tracker),
  count(g, Tracker, CountG),
  CountG >= 5,
  write('Green wins!').

check_win(Game).

/**
  @desc Updates the majority tracker and refreshes it on the game class.
*/
add_to_tracker(Game, Player, TableIndex, UpdatedGame) :-
  get_tracker(Game, Tracker),
  replace(Tracker, TableIndex, Player, UpdatedTracker),
  replace(Game, 1, UpdatedTracker, UpdatedGame).

/**
  @desc Updates the waiter's position on the Game class.
*/
update_waiter(Game, SeatIndex, WaiterFixed) :-
  get_waiter(Game, Waiter),

  nth0(0, Waiter, ArraySeatIndex),
  write('ESta e a nova mesa:'), write(SeatIndex),

  replace(Game, 5, [SeatIndex, ArraySeatIndex], WaiterFixed).

% Switches current turn.
switch_turn(Game, UpdatedGame) :-
  get_turn(Game, Turn),
  Turn = g,
  replace(Game, 3, b, UpdatedGame).

switch_turn(Game, UpdatedGame) :-
  get_turn(Game, Turn),
  Turn = b,
  replace(Game, 3, g, UpdatedGame).

empty_board([
  [x, x, x, x, x, x, x, x, x],
  [x, x, x, x, x, x, x, x, x],
  [x, x, x, x, x, x, x, x, x],
  [x, x, x, x, x, x, x, x, x],
  [x, x, x, x, x, x, x, x, x],
  [x, x, x, x, x, x, x, x, x],
  [x, x, x, x, x, x, x, x, x],
  [x, x, x, x, x, x, x, x, x],
  [x, x, x, x, x, x, x, x, x]]
).

special_actions(['MoveBlack', 'MoveGreen', 'WaiterBlack', 'WaiterGreen', 'Rotate1', 'Rotate2', 'SwapUnclaimed', 'SwapMixed']).

majority_tracker([x, x, x, x, x, x, x, x, x]).
