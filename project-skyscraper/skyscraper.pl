:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(clpfd)).
:- use_module(library(random)).

:- include('display.pl').
:- include('helpers.pl').
:- include('generator.pl').

:- dynamic clue/2.

skyscraper :-
	write('\nInsert a board size to generate: '),
	read(BoardSize), % Ask user for a board size to generate.
	
	format('\nGenerating a ~dx~d board...\n', [BoardSize, BoardSize]),
	generate_full_board(BoardSize, Board),
	display_board(Board),

	format('\nGenerating clues...\n', []),
	generate_clues(Board).

	%solve_board(Board),
	%append(Board, FlatBoard),
	%start_timer, labeling([], FlatBoard),
	%display_board(Board), print_timer.

/**
 *	Handles static puzzles.
**/
skyscraper(Puzzle) :-
	atom_concat(generate_, Puzzle, Generator),
	call(Generator, Board),

	solve_board(Board),
	append(Board, FlatBoard),
	start_timer, labeling([], FlatBoard),
	display_board(Board), print_timer.






/**
 *	Solves board based on restrictions code.
**/
solve_board(Board) :-
	length(Board, Size),
	declare_board_domain(Board, Size),

	maplist(all_distinct, Board), % Every row has unique values.
	clue(left-LeftClues), clue(right-RightClues),
	apply_clues(Board, LeftClues, RightClues),

	transpose(Board, InvertedBoard),
	maplist(all_distinct, InvertedBoard),
	clue(top-TopClues), clue(bottom-BottomClues),
	apply_clues(InvertedBoard, TopClues, BottomClues).

/**
 *	Apply clues restrictions.
**/
apply_clues([], [], []).

apply_clues([BH|BT], [CH1|CT1], [CH2|CT2]) :-
	reverse(BH, BH_Rev),

	CH1 \= 0, get_seen_buildings(BH_Rev, Seen_Rev), Seen_Rev #= CH1,
	CH2 \= 0, get_seen_buildings(BH, Seen), Seen #= CH2,

	apply_clues(BT, CT1, CT2).

apply_clues([BH|BT], [CH1|CT1], [CH2|CT2]) :-
	CH2 \= 0, get_seen_buildings(BH, Seen), Seen #= CH2,
	apply_clues(BT, CT1, CT2).

apply_clues([BH|BT], [CH1|CT1], [CH2|CT2]) :-
	apply_clues(BT, CT1, CT2).









