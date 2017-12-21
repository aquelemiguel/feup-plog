:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(random)).

/**
 *	Generates the tutorial puzzle at https://www.brainbashers.com/skyscrapershelp.asp.
 *	Uses a 4x4 grid, clues on every direction.
**/
generate_brainbashers(Board) :-
	retractall(clue(_)), % Clear memory first from previous generations.
	generate_empty_board(4, Board),

	assertz(clue(left-[1,2,2,2])), assertz(clue(right-[4,3,1,2])), 
	assertz(clue(top-[1,2,3,3])), assertz(clue(bottom-[3,3,1,2])).

/**
 *	Generates the puzzle at http://logicmastersindia.com/lmitests/dl.asp?attachmentid=659&view=1.
 *	Uses a 6x6 grid, missing clues on some directions (represented as zeros).
**/
generate_logicmasters(Board) :-
	retractall(clue(_)), % Clear memory first from previous generations.
	generate_empty_board(6, Board),

	assertz(clue(left-[0,2,3,4,0,0])), assertz(clue(right-[0,0,4,3,2,0])),
	assertz(clue(top-[5,0,0,2,2,0])), assertz(clue(bottom-[0,3,4,0,0,4])).

/**
 *	Generates an uninitialized [Size]x[Size] matrix.
**/
generate_empty_board(Size, Matrix) :-
	bagof(R, Y ^ (between(1, Size, Y), length(R, Size)), Matrix).

/**
 *	Generates a full [Size]x[Size] matrix.
 *	Based on the randomly generated board, clues are computed and a new puzzle is created.
**/
generate_full_board(Size, Matrix) :-
	generate_empty_board(Size, Matrix),

	declare_board_domain(Matrix, Size),

	maplist(all_distinct, Matrix),
	transpose(Matrix, MatrixRev),
	maplist(all_distinct, MatrixRev),

	append(Matrix, FlatMatrix),
	labeling([value(get_random_label)], FlatMatrix). % Generate a random matrix.

/**
 *	Generates clues.
 *	TODO: Doesn't actually generate anything so far.
**/
generate_clues(Board) :-
	retractall(clue(_)),
	transpose(Board, BoardRev),

	generate_left_top_clues(Board, Clues1), write(Clues1),
	generate_right_bottom_clues(Board, Clues2), write(Clues2),
	generate_left_top_clues(BoardRev, Clues3), write(Clues3),
	generate_right_bottom_clues(BoardRev, Clues4), write(Clues4).

/**
 *	Extracts LEFT/TOP clues from the provided board.
**/
generate_left_top_clues([], []).

generate_left_top_clues([H|T], [HC|TC]) :-
	generate_left_top_clues(T, TC),
	reverse(H, HRev),
	get_seen_buildings(HRev, Result),
	HC = Result.

generate_left_top_clues(_, []).

/**
 *	Extracts RIGHT/BOTTOM clues from the provided board.
**/
generate_right_bottom_clues([], []).

generate_right_bottom_clues([H|T], [HC|TC]) :-
	generate_right_bottom_clues(T, TC),
	get_seen_buildings(H, Result),
	HC = Result.

generate_right_bottom_clues(_, []).

/**
 *
**/
get_random_label(Var, Rest, BB, BB1) :-
	fd_set(Var, Set),
	select_random_value(Set, Value),
	(first_bound(BB, BB1), Var #= Value; later_bound(BB, BB1), Var #\= Value).

select_random_value(Set, RandomValue) :-
	fdset_to_list(Set, List),
	length(List, Len),
	random(0, Len, RandomIndex),
	nth0(RandomIndex, List, RandomValue).


/**
 *	Declarates domain on every cell.
**/
declare_board_domain([], _).

declare_board_domain([H|T], Size) :-
	domain(H, 1, Size),
	declare_board_domain(T, Size).

/**
 *	Assigns [Result] to the no. of buildings seen from the left-most position on a list.
 *	
**/
get_seen_buildings([], 0).

get_seen_buildings([H|T], Result) :-
  get_seen_buildings(T, TokenResult),
  maximum(Max, [H|T]),
  H #= Max #<=> Seen,
  Result #= TokenResult + Seen.



