display_board(Board) :-
	display_line(Board).

display_line([]).

display_line([H|T]) :-
	format('~q\n', [H]),
	display_line(T).
	
/**
 *	Prints runtime execution statistics in seconds, rounded to 3 decimal places.
**/
start_timer :- statistics(walltime, _).
print_timer :- 
	statistics(walltime, [_, T]),
	format('\nRuntime: ~3f seconds.\n\n', [T / 1000]).
