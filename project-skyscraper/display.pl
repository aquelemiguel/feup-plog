display_board(Board, BoardSize) :-
	write('  '), clue(top-TopClues), display_horizontal_clues(BoardSize, TopClues),

	display_top_line(BoardSize),
	start_iteration(Board, 1, BoardSize).

start_iteration([], _, BoardSize) :-
	write(' '), display_bottom_line(BoardSize),
	write('  '), clue(bottom-BottomClues), display_horizontal_clues(BoardSize, BottomClues).

start_iteration([H|T], Index, BoardSize) :-
	clue(left-LeftClues), nth1(Index, LeftClues, LeftClue),
	format('~d', [LeftClue]),
	put_code(179), display_line(H, Index, BoardSize), nl,

	NewIndex is Index + 1,
	start_iteration(T, NewIndex, BoardSize).

/**
 *	Displays the horizontal clues.
**/
display_horizontal_clues(_, []).

display_horizontal_clues(BoardSize, [H|T]) :-
	format('~d  ', [H]),
	display_top_clues(BoardSize, T).

/**
 *	Displays a single line from the board.
 *	At its last iteration, adds the surrounding board limits.
**/
display_line([], Index, BoardSize) :-
	length(SpaceList, BoardSize), maplist(=('   '), SpaceList),

	write('\b\b'), put_code(179), 

	clue(right-RightClues), nth1(Index, RightClues, RightClue),
	format('~d', [RightClue]),

	nl, write(' '),
	BoardSize \= Index,
	put_code(179), maplist(write, SpaceList), write('\b\b'), put_code(179).

display_line([H|T], Index, BoardSize) :-
	format('~d  ', [H]),
	display_line(T, Index, BoardSize).

display_line(_, _, _) :- write('\b\b').

/**
 *	Displays a stylized bottom and top line for the board.
**/
display_top_line(BoardSize) :-
	write(' '), put_code(218), 
	length(SpaceList, BoardSize), maplist(=('---'), SpaceList),
	maplist(write, SpaceList), write('\b\b'), put_code(191), write(' '), nl.

display_bottom_line(BoardSize) :-
	put_code(192),
	length(SpaceList, BoardSize), maplist(=('---'), SpaceList),
	maplist(write, SpaceList), write('\b\b'), put_code(217), write('  '), nl.
	
	
/**
 *	Prints runtime execution statistics in seconds, rounded to 3 decimal places.
**/
start_timer :- statistics(walltime, _).
print_timer :- 
	statistics(walltime, [_, T]),
	format('\nRuntime: ~3f seconds.\n\n', [T / 1000]).
