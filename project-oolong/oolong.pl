:- use_module(library(lists)).

:- include('game.pl').
:- include('menus.pl').
:- include('outputs.pl').
:- include('utilities.pl').

oolong :- main_menu. % Entry function call.

start_game(Game) :-
  get_board(Game, Board),
  print_board(Game, Board, 0),
  get_gamemode(Game, Mode), Mode = 1,
  play_turn(Game, UpdatedGame),
  start_game(UpdatedGame).

/**
  @desc Prompts next position from current player.
*/
play_turn(Game, UpdatedGame) :-
  read(SeatIndex),

  validate_move(Game, SeatIndex),
  write('Play validated!'), nl,
  place_piece(Game, SeatIndex, UpdatedGame),

  get_board(UpdatedGame, Board),
  get_table_index(Game, TableIndex),
  nth1(TableIndex, Board, Table),

  trigger_special(UpdatedGame, TableIndex, WhateverGame),

  check_majority(UpdatedGame, Table, UpdatedGame2),
  check_win(UpdatedGame2).

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

/**
  @desc Triggers the special markers.
*/
trigger_special(Game, TableIndex, UpdatedGame) :-

  get_board(Game, Board),
  nth1(TableIndex, Board, Table),
  get_special(Game, Special),

  TableIndex = 5, % Ignores the center table.
  write('Center has no special markers assigned.'), nl.

trigger_special(Game, TableIndex, UpdatedGame) :-

  get_board(Game, Board),
  nth1(TableIndex, Board, Table),
  get_special(Game, Special),

  TableIndex < 5,
  nth1(TableIndex, Special, Marker),
  write('This marker is '), write(Marker), write('.'), nl.

trigger_special(Game, TableIndex, UpdatedGame) :-

  get_board(Game, Board),
  nth1(TableIndex, Board, Table),
  get_special(Game, Special),

  TableIndex > 5,
  DecrementedTableIndex is TableIndex - 1,
  nth1(DecrementedTableIndex, Special, Marker),
  write('This marker is '), write(Marker), write('.'), nl.







