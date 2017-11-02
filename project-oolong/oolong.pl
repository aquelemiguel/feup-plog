:- use_module(library(lists)).

:- include('game.pl').
:- include('menus.pl').
:- include('outputs.pl').
:- include('utilities.pl').

oolong :- main_menu. % Entry function call.

start_game(Game) :-
  get_board(Game, Board),
  print_board(Board),
  get_gamemode(Game, Mode), Mode = 1,
  play_turn(Game, UpdatedGame),
  start_game(UpdatedGame).

/**
  @desc Prompts next position from current player.
*/
play_turn(Game, UpdatedGame) :-
  read(SeatSimpleIndex),
  SeatIndex is SeatSimpleIndex - 1,
  validate_move(Game, SeatIndex),
  write('Play validated!'),
  place_piece(Game, SeatIndex, UpdatedGame).

play_turn(Game) :- play_turn(Game).

/**
  @desc Checks whether the inputted seat is either already occupied or out of bounds.
*/
validate_move(Game, SeatIndex) :-
  SeatIndex >= 0, SeatIndex =< 8,

  get_board(Game, Board),
  get_table_index(Game, TableIndex),

  nth0(TableIndex, Board, Table),
  nth0(SeatIndex, Table, Seat),

  Seat = x.

validate_move(Game, SeatIndex) :-
  (SeatIndex < 0; SeatIndex > 8),
  write('Seat out of bounds!'), fail.

validate_move(Game, SeatIndex) :-
  
  get_board(Game, Board),
  get_table_index(Game, TableIndex),

  nth0(TableIndex, Board, Table),
  nth0(SeatIndex, Table, Seat),

  Seat \= x,
  write('Seat already occupied!'), fail.
