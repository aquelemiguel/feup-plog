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
	labeling([], FlatBoard),
	display_board(Board).

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

	maplist(all_distinct, Board), % Ensures every row has an unique value.
	transpose(Board, InvertedBoard),
	maplist(all_distinct, InvertedBoard). % Ensures every column has an unique value.

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
	assertz(clue(down, [3,3,1,2])).

/**
 *	Data structure declarations.
**/

