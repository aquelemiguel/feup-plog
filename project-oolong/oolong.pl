:- use_module(library(lists)).

play :-
  write('Welcome to PrOolong.'), nl,
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

trim(L,N,S) :- length(P,N), append(P,S,L).

print_board([]).
print_block([]).
print_line([]).

print_board([H|T]) :-
  print_block([H|T]),
  trim(T, 2, Remain), % Removes the top 9x3 block.
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
