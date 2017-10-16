start_game(Game, GameMode) :-
  Game = [Board, blackPlayer, GameMode].

% Game class getters.
get_board(Game, Board) :-
  nth0(0, Game, Board).

get_turn(Game, Player) :-
  nth(1, Game, Player).

get_game_mode(Game, GameMode) :-
  nth0(2, Game, GameMode).
