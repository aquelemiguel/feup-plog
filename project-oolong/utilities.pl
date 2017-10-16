clear_console :-
  clear_console(40), !.

clear_console(0).

clear_console(N) :-
  nl, N1 is N - 1, clear_console(N1).
