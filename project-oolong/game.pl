init_game(Game, GameMode) :-
  empty_board(Board),
  special_actions(Special),
  Game = [Board, Special, blackPlayer, GameMode],
  start_game(Game).


% Game class getters.
get_board(Game, Board) :-
  nth0(0, Game, Board).

get_special(Game, Special) :-
  nth0(1, Game, Special).

get_turn(Game, Player) :-
  nth0(2, Game, Player).

get_gamemode(Game, GameMode) :-
  nth0(3, Game, GameMode).

% Player and pieces.
player(greenPlayer).
player(blackPlayer).

piece(greenPiece).
piece(blackPiece).

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
