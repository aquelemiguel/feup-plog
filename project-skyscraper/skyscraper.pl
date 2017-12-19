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

	write(Board),
	solve_board(Board).

/**
 *	Generates a matrix with the provided size, thus it being sizeXsize.
**/
generate_board(Size, Matrix) :-
	bagof(R, Y^(between(1, Size, Y), length(R, Size)), Matrix).

/**
 *	Solves board based on restrictions code.
**/
solve_board(Board) :-
	test_board(Board),
	length(Board, Size),

	declare_board_domain(Board, Size),

	unique_values_row(Board),
	%unique_values_column(Board),

	label_board(Board).


declare_board_domain([], _).

declare_board_domain([H|T], Size) :-
	domain(H, 1, Size),
	declare_board_domain(T, Size).

label_board([]).
label_board([H|T]) :-
	labeling([], H), label_board(T).

unique_values_row([]).
unique_values_column([]).

unique_values_row([H|T]) :-
	all_distinct(H),
	unique_values_row(T).

	




/**
 *	Generates clues.
 *	TODO: Doesn't actually generate anything so far.
**/
generate_clues(BoardSize, Clues) :-
	retractall(clue),

	assertz(clue(top, [1,2,3,3])),
	assertz(clue(left, [1,2,2,2])),
	assertz(clue(right, [4,3,1,2])),
	assertz(clue(down, [3,3,1,2])).

/**
 *	Data structure declarations.
**/

