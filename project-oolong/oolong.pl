:- use_module(library(lists)).

play :-
  nl, write('Welcome to PrOolong.'), nl,
  % read(Input),
  game([
    [a, b, c, d, e, f, g, h, i],
    [g, b, c, d, e, f, g, h, i],
    [h, b, c, d, e, f, g, h, i],
    [i, b, c, d, e, f, g, h, i],
    [j, b, c, d, e, f, g, h, i],
    [k, b, c, d, e, f, g, h, i],
    [l, b, c, d, e, f, g, h, i],
    [m, b, c, d, e, f, g, h, i],
    [n, b, c, d, e, f, g, h, i]],

    [b, b, b, b, b, b, b, b, b], % Special cards array.

    [b, g, b, g, x, g, g, g, x] % Tile majority tracker.
  ).

trim_head(L,N,S) :- length(P,N), append(P,S,L). % Trims head of list. L=list N=amount S=result P=sized list
trim_tail(L,N,S) :- reverse(L,R), length(P,N), append(P,K,R), reverse(K,S).

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
  nl, put_code(200), put_code(205), put_code(205), put_code(205), put_code(202), put_code(205), put_code(205), put_code(205), put_code(202), put_code(205),
  put_code(205), put_code(205), put_code(188), nl.

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

  print_formatted_line(1), put_code(186),

  nth0(3, H, E10), write(E10), write(' '), put_code(186),
  nth0(4, H, E11), write(E11), write(' '), put_code(186),
  nth0(5, H, E12), write(E12), write('    '),

  nth0(3, A1, E13), write(E13), write('  '),
  nth0(4, A1, E14), write(E14), write('  '),
  nth0(5, A1, E15), write(E15), write('    '),

  nth0(3, A2, E16), write(E16), write('  '),
  nth0(4, A2, E17), write(E17), write('  '),
  nth0(5, A2, E18), write(E18),

  print_formatted_line(1), put_code(186),

  nth0(6, H, E19), write(E19), write('  '),
  nth0(7, H, E20), write(E20), write('  '),
  nth0(8, H, E21), write(E21), write('    '),

  nth0(6, A1, E22), write(E22), write('  '),
  nth0(7, A1, E23), write(E23), write('  '),
  nth0(8, A1, E24), write(E24), write('    '),

  nth0(6, A2, E25), write(E25), write('  '),
  nth0(7, A2, E26), write(E26), write('  '),
  nth0(8, A2, E27), write(E27), nl,

  print_formatted_line(2),

  nl.



/*
print_board([H|T]) :-
  length([H|T], Size), % Size of matrix.
  trim_tail([H|T], Size, Block),
  print_block(Block),
  trim_head(T, 2, Remain), % Removes the top 9x3 block.
  print_board(Remain).

print_block([H|T]) :-
  print_line([H|T]), nl,
  print_block(T).

print_line([H|T]) :-
  nth0(0, H, E1), write(E1),
  nth0(1, H, E2), write(E2),
  nth0(2, H, E3), write(E3),

  nth0(0, T, A1), write(' '),

  nth0(0, A1, E4), write(E4),
  nth0(1, A1, E5), write(E5),
  nth0(2, A1, E6), write(E6),

  nth0(1, T, A2), write(' '),

  nth0(0, A2, E7), write(E7),
  nth0(1, A2, E8), write(E8),
  nth0(2, A2, E9), write(E9).
*/

% print_line([]) :- nl.
% print_line([C|T]) :- write(C), write('|'), print_line(T).

game(Board, Special, Majority) :-
  print_board(Board),
  win(b, Majority), write('Black wins!').

game(Board, Special, Majority) :-
  %print_board(Board),
  win(g, Majority), write('Green wins!').

count([], 0).
count([H|T], N) :- number(H), count(T, N1), N is N1 + 1.
count([H|T], N) :- \+number(H), count(T, N).

win(X, Majority) :-
  count(Majority, X), % This predicate does not exist, create it.
  Y >= 5.
