init_game(Game, GameMode, BotDifficulty) :-
  empty_board(Board),

  special_actions(TempSpecial),
  random_permutation(TempSpecial, TempShuffled),

  trim_tail(TempShuffled, 4, Head),
  trim_head(TempShuffled, 4, Tail),

  append(Head, ['Empty'], Shuffled1),
  append(Shuffled1, Tail, Shuffled),

  majority_tracker(Tracker),

  Game = [Board, Tracker, Shuffled, b, [5,5], GameMode, BotDifficulty],
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

get_waiter(Game, Waiter) :-
  nth0(4, Game, Waiter).

get_gamemode(Game, GameMode) :-
  nth0(5, Game, GameMode).

get_bot_difficulty(Game, Difficulty) :-
  nth0(6, Game, Difficulty).

get_table(Game, Index, Table) :-
  get_board(Game, Board),
  nth0(Index, Board, Table).

get_opponent(b, g).
get_opponent(g, b).

get_full_name(b, 'BLACK').
get_full_name(g, 'GREEN').

/**
  @desc Places the current player's piece on the provided seat.
*/
place_piece(Game, SeatIndex, UpdatedGame) :-
  get_board(Game, Board),
  get_waiter(Game, Waiter),
  nth0(0, Waiter, TableIndex),
  get_turn(Game, Player),

  nth1(TableIndex, Board, Table),

  TableTempIndex is TableIndex - 1,
  SeatTempIndex is SeatIndex - 1,

  replace(Table, SeatTempIndex, Player, NewTable),
  replace(Board, TableTempIndex, NewTable, NewBoard),

  update_waiter(Game, SeatIndex, WaiterFixed),

  replace(WaiterFixed, 0, NewBoard, UpdatedGame).

/**
  @desc Determines whether a player has filled 5 out of 9 seats on a table, thus claiming majority on it.
*/
check_majority(Game, Table, UpdatedGame) :-
  count(b, Table, CountB),
  CountB = 5,
  get_waiter(Game, Waiter),
  nth0(1, Waiter, TableIndex),
  add_to_tracker(Game, b, TableIndex, UpdatedGame).

check_majority(Game, Table, UpdatedGame) :-
  count(g, Table, CountG),
  CountG = 5,
  get_waiter(Game, Waiter),
  nth0(1, Waiter, TableIndex),
  add_to_tracker(Game, g, TableIndex, UpdatedGame).

check_majority(Game, _, UpdatedGame) :-
  append(Game, [], UpdatedGame). % Copies the unaltered game class to UpdatedGame so check_win functions correctly.

/**
  @desc Determines whether a player has filled 5 out of 9 tables, thus winning the game.
*/
check_win(Game) :-
  get_tracker(Game, Tracker),
  count(b, Tracker, CountB),
  ite(CountB >= 5, (write('Black wins!'), sleep(3), main_menu), fail).

check_win(Game) :-
  get_tracker(Game, Tracker),
  count(g, Tracker, CountG),
  ite(CountG >= 5, (write('Green wins!'), sleep(3), main_menu), fail).

check_win(_).

/**
  @desc Updates the majority tracker and refreshes it on the game class.
*/
add_to_tracker(Game, Player, TableIndex, UpdatedGame) :-
  get_tracker(Game, Tracker),nl,
  TableTempIndex is TableIndex - 1,
  replace(Tracker, TableTempIndex, Player, UpdatedTracker),
  replace(Game, 1, UpdatedTracker, UpdatedGame).

/**
  @desc Updates the waiter's position on the Game class.
*/
update_waiter(Game, SeatIndex, WaiterFixed) :-
  get_waiter(Game, Waiter),

  nth0(0, Waiter, ArraySeatIndex),

  replace(Game, 4, [SeatIndex, ArraySeatIndex], WaiterFixed).

update_waiter_table(Game, TableIndex, NewGame) :-
  get_waiter(Game, Waiter),

  nth0(1, Waiter, SeatIndex),

  replace(Game, 4, [TableIndex, SeatIndex], NewGame).




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
