display_board(Board) :-
	display_line(Board).

display_line([]).

display_line([H|T]) :-
	format('~q\n', [H]),
	display_line(T).
	

