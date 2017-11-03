init_game(Game, GameMode) :-
  empty_board(Board),
  special_actions(Special),
  Game = [Board, Special, b, 4, [5,5], GameMode],
  start_game(Game).

% Game class getters.
get_board(Game, Board) :-
  nth0(0, Game, Board).

get_special(Game, Special) :-
  nth0(1, Game, Special).

get_turn(Game, Player) :-
  nth0(2, Game, Player).

get_table_index(Game, TableIndex) :-
  nth0(3, Game, TableIndex).

get_waiter(Game, Waiter) :-
  nth0(4, Game, Waiter).

get_gamemode(Game, GameMode) :-
  nth0(5, Game, GameMode).

/**
  @desc Places the current player's piece on the provided seat.
*/
place_piece(Game, SeatIndex, UpdatedGame) :-
  get_board(Game, Board),
  get_table_index(Game, TableIndex),
  get_turn(Game, Player),

  nth0(TableIndex, Board, Table),
  replace(Table, SeatIndex, Player, NewTable),
  replace(Board, TableIndex, NewTable, NewBoard),

  update_waiter(Game, WaiterFixed, SeatIndex),

  replace(WaiterFixed, 0, NewBoard, TempGame),
  switch_turn(TempGame, AnotherTemp),
  replace(AnotherTemp, 3, SeatIndex, UpdatedGame).

/**
  @desc Updates the waiter's position on the Game class.
*/
update_waiter(Game, WaiterFixed, SeatIndex) :-
  get_waiter(Game, Waiter),
  get_table_index(Game, TableIndex),

  ArraySeatIndex is SeatIndex + 1,
  ArrayTableIndex is TableIndex + 1,

  replace(Game, 4, [ArraySeatIndex, ArrayTableIndex], WaiterFixed).

% Switches current turn.
switch_turn(Game, UpdatedGame) :-
  get_turn(Game, Turn),
  Turn = g,
  replace(Game, 2, b, UpdatedGame).

switch_turn(Game, UpdatedGame) :-
  get_turn(Game, Turn),
  Turn = b,
  replace(Game, 2, g, UpdatedGame).

% Initial boards.
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

special_actions([b, b, b, b, b, b, b, b, b]).
