:- use_module(library(lists)).

:- include('game.pl').
:- include('menus.pl').
:- include('outputs.pl').
:- include('utilities.pl').

oolong :- main_menu. % Entry function call.

start_game(Game) :-
  get_board(Game, Board),
  switch_turn(Game, UpdatedGame),
  print_board(Board).






game(Board, _, Majority) :-
  print_board(Board),
  win(b, Majority), write('Black wins!').

game(Board, Special, Majority) :-
  %print_board(Board),
  win(g, Majority), write('Green wins!').

% Movement predicates.
place_token(Board, Color, [H|T]) :-
  Color = b,
  nth0(H, Board, Sel_Line),
  nth0(T, Sel_Line, Sel_Pos),
  Sel_Pos = x,
  Sel_Pos is Color, % This probably doesn't do anything, need formatted code to check.
  print_board(Board).

place_token(Board, Color, [H|T]) :-
  Color = g,
  nth0(H, Board, Sel_Line),
  nth0(T, Sel_Line, Sel_Pos),
  Sel_Pos = x,
  Sel_Pos is Color, % This probably doesn't do anything, need formatted code to check.
  print_board(Board).

% TODO: Waiter should only be implemented when board's optimized.




/*
print_board([]).
print_block([]).

print_board([H|T]) :-
  length([H|T], Matrix_Size),
  Trim_Size is Matrix_Size - 3,
  trim_tail([H|T], Trim_Size, Block),
  print_block(Block),
  trim_head(T, 2, Remain),
  print_board(Remain).

print_formatted_line(X) :-
  X = 0,
  put_code(201), put_code(205), put_code(205), put_code(205), put_code(203), put_code(205), put_code(205), put_code(205), put_code(203), put_code(205),
  put_code(205), put_code(205), put_code(187).

print_formatted_line(X) :-
  X = 1,
  nl, put_code(204), put_code(205), put_code(205), put_code(205), put_code(206), put_code(205), put_code(205), put_code(205), put_code(206), put_code(205),
  put_code(205), put_code(205), put_code(185), nl.

print_formatted_line(X) :-
  X = 2,
  put_code(200), put_code(205), put_code(205), put_code(205), put_code(202), put_code(205), put_code(205), put_code(205), put_code(202), put_code(205),
  put_code(205), put_code(205), put_code(188).

print_formatted_line(X) :-
  X = 3,
  put_code(204), put_code(205), put_code(205), put_code(205), put_code(206), put_code(205), put_code(205), put_code(205), put_code(206), put_code(205),
  put_code(205), put_code(205), put_code(185), write(' ').

% This implementation looks like absolute shit.
print_block([H|T]) :- nl, nl,
  nl, print_formatted_line(0), write(' '), print_formatted_line(0), write(' '), print_formatted_line(0), nl,

  put_code(186), write(' '),

  nth0(0, H, E1), write(E1), write(' '), put_code(186), write(' '),
  nth0(1, H, E2), write(E2), write(' '), put_code(186), write(' '),
  nth0(2, H, E3), write(E3), write(' '), put_code(186), write(' '), put_code(186),

  nth0(0, T, A1),

  nth0(0, A1, E4), write(' '), write(E4), write(' '), put_code(186),
  nth0(1, A1, E5), write(' '), write(E5), write(' '), put_code(186),
  nth0(2, A1, E6), write(' '), write(E6), write(' '), put_code(186), write(' '), put_code(186),

  nth0(1, T, A2),

  nth0(0, A2, E7), write(' '), write(E7), write(' '), put_code(186),
  nth0(1, A2, E8), write(' '), write(E8), write(' '), put_code(186),
  nth0(2, A2, E9), write(' '), write(E9), write(' '), put_code(186),

  nl,print_formatted_line(3), print_formatted_line(3), print_formatted_line(3), nl,

  put_code(186),

  nth0(3, H, E10), write(' '), write(E10), write(' '), put_code(186),
  nth0(4, H, E11), write(' '), write(E11), write(' '), put_code(186),
  nth0(5, H, E12), write(' '), write(E12), write(' '), put_code(186), write(' '),

  put_code(186), write(' '),

  nth0(3, A1, E13), write(E13), write(' '), put_code(186), write(' '),
  nth0(4, A1, E14), write(E14), write(' '), put_code(186), write(' '),
  nth0(5, A1, E15), write(E15), write(' '), put_code(186), write(' '),

  put_code(186), write(' '),

  nth0(3, A2, E16), write(E16), write(' '), put_code(186), write(' '),
  nth0(4, A2, E17), write(E17), write(' '), put_code(186), write(' '),
  nth0(5, A2, E18), write(E18), write(' '), put_code(186), write(' '),

  nl,print_formatted_line(3), print_formatted_line(3), print_formatted_line(3), nl,

  put_code(186), write(' '),

  nth0(6, H, E19), write(E19), write(' '), put_code(186), write(' '),
  nth0(7, H, E20), write(E20), write(' '), put_code(186), write(' '),
  nth0(8, H, E21), write(E21), write(' '), put_code(186), write(' '), put_code(186),

  write(' '),

  nth0(6, A1, E22), write(E22), write(' '), put_code(186), write(' '),
  nth0(7, A1, E23), write(E23), write(' '), put_code(186), write(' '),
  nth0(8, A1, E24), write(E24), write(' '), put_code(186), write(' '), put_code(186),

  write(' '),

  nth0(6, A2, E25), write(E25), write(' '), put_code(186), write(' '),
  nth0(7, A2, E26), write(E26), write(' '), put_code(186), write(' '),
  nth0(8, A2, E27), write(E27), write(' '), put_code(186),

  nl, print_formatted_line(2), write(' '), print_formatted_line(2), write(' '), print_formatted_line(2),

  nl.
*/
