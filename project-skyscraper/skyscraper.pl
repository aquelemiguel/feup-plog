:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(clpfd)).

:- include('display.pl').
:- include('helpers.pl').

:- dynamic clue/2.

skyscraper :-
	write('Insert a board size to generate: '),
	read(BoardSize), % Ask user for a board size to generate.
	
	format('Generating a ~dx~d board...\n', [BoardSize, BoardSize]),
	generate_board(BoardSize, Board), % Generate said board.

	generate_clues(BoardSize, Clues), % Generate clues for the board.

	solve_board(Board),
	append(Board, FlatBoard),
	start_timer, labeling([], FlatBoard),
	display_board(Board), print_timer.

/**
 *	Solves the tutorial puzzle at https://www.brainbashers.com/skyscrapershelp.asp.
 *	Uses a 4x4 grid, clues on every direction.
**/
skyscraper(Index) :-
	Index = 0,
	generate_board(4, Board),
	generate_clues(4, Clues),

	solve_board(Board),
	append(Board, FlatBoard),

	start_timer, labeling([], FlatBoard),
	display_board(Board), print_timer.

/**
 *	Generates a matrix with the provided size, thus it being sizeXsize.
**/
generate_board(Size, Matrix) :-
	bagof(R, Y^(between(1, Size, Y), length(R, Size)), Matrix).

/**
 *	Solves board based on restrictions code.
**/
solve_board(Board) :-
	length(Board, Size),
	declare_board_domain(Board, Size),

	maplist(all_distinct, Board), % Every row has unique values.
	clue(left, LeftClues), clue(right, RightClues),
	apply_clues(Board, LeftClues, RightClues),

	transpose(Board, InvertedBoard),
	maplist(all_distinct, InvertedBoard),
	clue(top, TopClues), clue(bottom, BottomClues),
	apply_clues(InvertedBoard, TopClues, BottomClues).

/**
 *	Apply clues restrictions.
**/
apply_clues([], [], []).

apply_clues([BH|BT], [CH1|CT1], [CH2|CT2]) :-
	length(BH, Size),

	format('~d : ~d\n', [CH1, CH2]),

	% If the clue's 1, then it must be close to a 4.
	((CH1 = 1, nth0(0, BH, Elem), Elem #= 4);
	(CH2 = 1, nth1(Size, BH, Elem2), Elem2 #= 4); true),

	% If the clue's 4, then the numbers must be in ascending order.
	sort(BH, BH_Sorted),
	((CH1 = 4, assert_line_in_order(BH, BH_Sorted));
	(CH2 = 4, reverse(BH, BH_Rev), assert_line_in_order(BH_Rev, BH_Sorted)); true),

	apply_clues(BT, CT1, CT2).

/**
 *	Apply clues restrictions.
**/
assert_line_in_order([], []).

assert_line_in_order([H|T], [H_Sort|T_Sort]) :-
	H #= H_Sort,
	assert_line_in_order(T, T_Sort).
	






/**
 *	Declarates domain on every cell.
**/
declare_board_domain([], _).

declare_board_domain([H|T], Size) :-
	domain(H, 1, Size),
	declare_board_domain(T, Size).

	




/**
 *	Generates clues.
 *	TODO: Doesn't actually generate anything so far.
**/
generate_clues(BoardSize, Clues) :-
	retractall(clue),

	assertz(clue(top, [1,2,3,3])),
	assertz(clue(left, [1,2,2,2])),
	assertz(clue(right, [4,3,1,2])),
	assertz(clue(bottom, [3,3,1,2])).

/**
 *	Data structure declarations.
**/

