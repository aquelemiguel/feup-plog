factorial(0, 1).
factorial(1, 1).
factorial(N, V) :-
  N > 1,
  N1 is N - 1, factorial(N1, V1),
  V is N * V1.

factorialAcc(X, Y) :-
  fac(X, 1, Y).

fac(1, V, V).
fac(N, Acc, V) :-
  N > 1,
  N1 is N - 1,
  Acc1 is Acc * N,
  fac(N1, Acc1, V).
