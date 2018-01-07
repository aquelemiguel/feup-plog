:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(clpfd)).
:- use_module(library(random)).

:- include('display.pl').
:- include('helpers.pl').
:- include('generator.pl').

:- dynamic clue/1.

skyscraper :-
	write('\nBoard size to generate: '),
	read(BoardSize), % Ask user for a board size to generate.
	
	format('\nGenerating a ~dx~d board... ', [BoardSize, BoardSize]),
	generate_full_board(BoardSize, CheatBoard),
	write('Done!\n'),

	format('Generating clues... ', []),
	generate_clues(CheatBoard),
	write('Done!\n'),

	generate_empty_board(BoardSize, Board),

	format('Solving... ', []),
	solve_board(Board),
	append(Board, FlatBoard),
	start_timer, labeling([], FlatBoard),
	
	write('Done!\n\n'),
	display_board(Board, BoardSize), print_timer.

/**
 *	Handles static puzzles.
**/
skyscraper(Puzzle) :-
	atom_concat(generate_, Puzzle, Generator),
	call(Generator, Board), length(Board, BoardSize),

	format('Solving... ', []),
	solve_board(Board),
	append(Board, FlatBoard),
	start_timer, labeling([], FlatBoard),

	write('Done!\n\n'),
	display_board(Board, BoardSize), print_timer.

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

apply_clues([BH|BT], [_|CT1], [CH2|CT2]) :-
	CH2 \= 0, get_seen_buildings(BH, Seen), Seen #= CH2,
	apply_clues(BT, CT1, CT2).

apply_clues([_|BT], [_|CT1], [_|CT2]) :-
	apply_clues(BT, CT1, CT2).