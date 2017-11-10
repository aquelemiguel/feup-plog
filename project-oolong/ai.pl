/**
  @desc Bot performs its play on the EASY difficulty.
		On EASY mode, the bot selects its piece positions randomly.
*/
bot_play_turn_easy(Game, UpdatedGame) :-
	
	get_board(Game, Board),
	get_table_index(Game, TableIndex),

	nth1(TableIndex, Board, Table),

	random_between(1, 9, SeatIndex),

	validate_move(Game, SeatIndex),
	place_piece(Game, SeatIndex, UpdatedGame2),

	trigger_special(UpdatedGame2, TableIndex, UpdatedGame3),

  	check_majority(UpdatedGame3, Table, UpdatedGame),
  	check_win(UpdatedGame).

bot_play_turn_easy(Game, UpdatedGame) :- 
	append(Game, [], UpdatedGame), 
	bot_play_turn_easy(Game, UpdatedGame). % If bot performs an invalid play.

/**
  @desc Bot performs its play on the NORMAL difficulty.
		On NORMAL mode, the bot (loosely) takes into account the various outcomes of his plays, but plays special markers randomly.
		If two choices are equally good, it randomly picks one.
*/
bot_play_turn_normal(Game, UpdatedGame) :-
	
	return_play_ratings(Game, 0, NewRatings, DefinitelyRatings), write(DefinitelyRatings), nl,
	max_list(DefinitelyRatings, Max),
	get_random_max_index(Max, DefinitelyRatings, SeatIndex), write('gotototoot: '), write(SeatIndex), nl,
	
	nth1(SeatIndex, DefinitelyRatings, Max), %write(SeatIndex),

	place_piece(Game, SeatIndex, UpdatedGame2),

	trigger_special(UpdatedGame2, TableIndex, UpdatedGame3),

  	check_majority(UpdatedGame3, Table, UpdatedGame),
  	check_win(UpdatedGame).

 bot_play_turn_normal(Game, UpdatedGame) :- 
 	append(Game, [], UpdatedGame), 
 	bot_play_turn_normal(Game, UpdatedGame). % If bot performs an invalid play.

/**
  @desc
*/
get_random_max_index(Max, List, SeatIndex) :-

	random_between(1, 9, Random),
	validate_move(Game, Random),
	nth1(Random, List, Elem),
	Elem = Max,
	SeatIndex is Random.

get_random_max_index(Max, List, SeatIndex) :- get_random_max_index(Max, List, SeatIndex).


/**
  @desc
*/
return_play_ratings(_, 9, NewRatings, DefinitelyRatings) :- append(NewRatings, [], DefinitelyRatings).

return_play_ratings(Game, SeatIndex, Ratings, DefinitelyRatings) :-

	get_turn(Game, Player),
	get_opponent(Player, Opponent),

	get_table(Game, SeatIndex, Table),
	count(Player, Table, CountP), 
	count(Opponent, Table, CountO),

	play_rating(CountP, CountO, Rating),
	append(Ratings, [Rating], NewRatings),

	NewIndex is SeatIndex + 1,

	return_play_ratings(Game, NewIndex, NewRatings, DefinitelyRatings).

/**
  @desc
*/
play_rating(0, 0, 5).
play_rating(0, 1, 4).
play_rating(0, 2, 3).
play_rating(0, 3, 2).
play_rating(0, 4, 1).
play_rating(0, 5, 10).
play_rating(0, 6, 10).
play_rating(0, 7, 10).
play_rating(0, 8, 10).
play_rating(0, 9, 0).

play_rating(1, 0, 6).
play_rating(1, 1, 5).
play_rating(1, 2, 4).
play_rating(1, 3, 3).
play_rating(1, 4, 1).
play_rating(1, 5, 10).
play_rating(1, 6, 10).
play_rating(1, 7, 10).
play_rating(1, 8, 0).

play_rating(2, 0, 7).
play_rating(2, 1, 6).
play_rating(2, 2, 5).
play_rating(2, 3, 4).
play_rating(2, 4, 1).
play_rating(2, 5, 10).
play_rating(2, 6, 10).
play_rating(2, 7, 0).

play_rating(3, 0, 8).
play_rating(3, 1, 7).
play_rating(3, 2, 6).
play_rating(3, 3, 5).
play_rating(3, 4, 1).
play_rating(3, 5, 10).
play_rating(3, 6, 0).

play_rating(4, 0, 9).
play_rating(4, 1, 8).
play_rating(4, 2, 7).
play_rating(4, 3, 6).
play_rating(4, 4, 1).
play_rating(4, 5, 0).

play_rating(5, 0, 10).
play_rating(5, 1, 10).
play_rating(5, 2, 10).
play_rating(5, 3, 10).
play_rating(5, 4, 0).

play_rating(6, 0, 10).
play_rating(6, 1, 10).
play_rating(6, 2, 10).
play_rating(6, 3, 0).

play_rating(7, 0, 10).
play_rating(7, 1, 10).
play_rating(7, 2, 0).

play_rating(8, 0, 10).
play_rating(8, 1, 0).

play_rating(9, 0, 0).






