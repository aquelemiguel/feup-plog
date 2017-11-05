init_game(Game, GameMode) :-
  empty_board(Board),

  special_actions(Special),
  random_permutation(Special, ShuffledSpecial),
  
  majority_tracker(Tracker),

  Game = [Board, Tracker, ShuffledSpecial, b, 5, [5,5], GameMode],
  start_game(Game).

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
  replace(AnotherTemp, 4, SeatIndex, UpdatedGame).

/**
  @desc
*/
check_majority(Game, Table) :-
  count(b, Table, CountB), write(CountB),
  count(g, Table, CountG), write(CountG).

/**
  @desc Updates the waiter's position on the Game class.
*/
update_waiter(Game, SeatIndex, WaiterFixed) :-
  get_waiter(Game, Waiter),
  get_table_index(Game, TableIndex),

  nth0(1, Waiter, ArraySeatIndex),

  replace(Game, 5, [ArraySeatIndex, SeatIndex], WaiterFixed).

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

special_actions(['MoveUUBlack', 'MoveUUGreen', 'WaiterBlack', 'WaiterGreen', 'Rotate1', 'Rotate2', 'SwapUU', 'SwapCU']).

majority_tracker([x, x, x, x, x, x, x, x, x]).
