% Somatório dos números até n.
somatorio(0, 0).
somatorio(1, 1).

somatorio(N, Res) :-
  N > 1,
  N1 is N - 1, somatorio(N1, Res1),
  Res is N + Res1.
