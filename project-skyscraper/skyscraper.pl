:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(clpfd)).

:- include('display.pl').
:- include('helpers.pl').

:- dynamic clue/2.
:- dynamic maximum/1.

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

	%format('~d : ~d\n', [CH1, CH2]),

	% If the clue's 1, then it must be next to a 4.
	%((CH1 = 1, nth0(0, BH, Elem), Elem #= 4);
	%(CH2 = 1, nth1(Size, BH, Elem2), Elem2 #= 4); true),

	% Calculate the no. of maximum switches.
	asserta(maximum(0)), reverse(BH, BH_Rev),
	calculate_max_switches(BH, 0, Switches),
	calculate_max_switches(BH_Rev, 0, Switches2),
	Switches #= CH1,

	apply_clues(BT, CT1, CT2).

calculate_max_switches([H|T], AuxSwitches, Switches) :-	
	maximum(Maximum),
	H > Maximum, retractall(maximum(_)), asserta(maximum(H)), 
	NewAuxSwitches is AuxSwitches + 1,
	calculate_max_switches(T, NewAuxSwitches, Switches).

calculate_max_switches([H|T], AuxSwitches, Switches) :-
	calculate_max_switches(T, AuxSwitches, Switches).

calculate_max_switches([], AuxSwitches, Switches) :-
	retractall(maximum(_)), Switches is AuxSwitches.




getLineReification([], 0).

getLineReification([H|T], Value) :-
  getLineReification(T, NewValue),
  maximum(A, [H|T]),
  H #= A #<=> S,
  Value #= NewValue + S.

	











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

