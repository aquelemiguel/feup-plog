:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(clpfd)).

:- include('board-display.pl').

:- dynamic clue/2.

skyscraper :-
	write('Insert a board size to generate: '),
	read(BoardSize), % Ask user for a board size to generate.
	
	format('Generating a ~dx~d board...\n', [BoardSize, BoardSize]),
	generate_board(BoardSize, Board), % Generate said board.
	generate_clues(BoardSize, Clues), % Generate clues for the board.

	display_board(Board).

/**
 *	Generates a YxY matrix, based on BoardSize.
**/
generate_board(BoardSize, Board) :-
	length(Rows, BoardSize),
	maplist(numlist(1, BoardSize), Rows),
	maplist(permutation, Rows, Board).

/**
 *	Generates clues.
 *	TODO: Doesn't actually generate anything so far.
**/
generate_clues(BoardSize, Clues) :-
	retractall(clue),

	assertz(clue('col'-0, 5, 0)),
	assertz(clue('col'-1, 0, 3)),
	assertz(clue('col'-2, 0, 4)),
	assertz(clue('col'-3, 2, 0)),
	assertz(clue('col'-4, 2, 0)),
	assertz(clue('col'-5, 0, 4)),

	assertz(clue('row'-0, 0, 0)),
	assertz(clue('row'-1, 2, 0)),
	assertz(clue('row'-2, 3, 4)),
	assertz(clue('row'-3, 4, 3)),
	assertz(clue('row'-4, 0, 2)),
	assertz(clue('row'-5, 0, 0)).



/**
 *	Data structure declarations.
**/

