play :-
  write('Welcome to PrOolong.'), nl,
  % read(Input),
  game([
    [b, b, b, b, b, b, b, b, b],
    [b, b, b, b, b, b, b, b, b],
    [b, b, b, b, b, b, b, b, b],
    [b, b, b, b, b, b, b, b, b],
    [b, b, b, b, b, b, b, b, b],
    [b, b, b, b, b, b, b, b, b],
    [b, b, b, b, b, b, b, b, b],
    [b, b, b, b, b, b, b, b, b],
    [b, b, b, b, b, b, b, b, b]],

    [b, b, b, b, b, b, b, b, b], % Special cards array.

    [b, g, b, g, x, g, g, g, x] % Tile majority tracker.
  ]).

game(Board, Special, Majority) :-
  win(b, Majority), write('Black wins!').

game(Board, Special, Majority) :-
  win(g, Majority), write('Green wins!').

count([], 0).
count([H|T], N) :- number(H), count(T, N1), N is N1 + 1.
count([H|T], N) :- \+number(H), count(T, N).

win(X, Majority) :-
  count(Majority, X, Y), % This predicate does not exist, create it.
  Y >= 5.
