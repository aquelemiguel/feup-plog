init_game(Game, GameMode) :-
  empty_board(Board),
  special_actions(Special),
  Game = [Board, Special, b, 4, GameMode],
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

get_gamemode(Game, GameMode) :-
  nth0(4, Game, GameMode).

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

  replace(Game, 0, NewBoard, UpdatedGame).

% Switches current turn.
switch_turn(Game, UpdatedGame) :-
  get_turn(Game, Turn),
  Turn = g,
  replace(Game, 2, b, UpdatedGame).

switch_turn(Game, Result) :-
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
