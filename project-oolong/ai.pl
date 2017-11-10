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

bot_play_turn_easy(Game, UpdatedGame) :- bot_play_turn_easy(Game, UpdatedGame).

/**
  @desc Bot performs its play on the NORMAL difficulty.
		On NORMAL mode, the bot (loosely) takes into account the various outcomes of his plays, but plays special markers randomly.
		If two choices are equally good, it randomly picks one.
*/
bot_play_turn_normal(Game, UpdatedGame) :-
	
	return_play_ratings(Game, 1, Ratings).

/**
  @desc
*/
return_play_ratings(_, 9, Ratings).

return_play_ratings(Game, SeatIndex, Ratings) :-
	
	play_rating(Game, SeatIndex, Rating),
	append(Ratings, Rating, NewRatings),

	NewIndex is SeatIndex + 1,

	return_play_ratings(Game, NewIndex, NewRatings).

/**
  @desc
*/
play_rating(Game, SeatIndex, Rating) :-
	
	validate_move(Game, SeatIndex),

	get_turn(Game, Player), Player = b,

	get_board(Game, Board),
	nth1(SeatIndex, Board, Table),
	count(g, Table, CountG), CountG = 0,

	Rating is 5.


play_rating(0, 0, 5).
play_rating(0, 1, 4).
play_rating(0, 2, 3).
play_rating(0, 3, 2).
play_rating(0, 4, 1).
play_rating(0, 5, 8).
play_rating(0, 6, 8).
play_rating(0, 7, 8).
play_rating(0, 8, 8).
play_rating(0, 9, 0).

play_rating(1, 0, 5).
play_rating(1, 1, 4).
play_rating(1, 2, 3).
play_rating(1, 3, 2).
play_rating(1, 4, 1).
play_rating(1, 5, 8).
play_rating(1, 6, 8).
play_rating(1, 7, 8).
play_rating(1, 8, 0).

play_rating(2, 0, 5).
play_rating(2, 1, 4).
play_rating(2, 2, 3).
play_rating(2, 3, 2).
play_rating(2, 4, 1).
play_rating(2, 5, 8).
play_rating(2, 6, 8).
play_rating(2, 7, 0).

play_rating(3, 0, 5).
play_rating(3, 1, 4).
play_rating(3, 2, 3).
play_rating(3, 3, 2).
play_rating(3, 4, 1).
play_rating(3, 5, 8).
play_rating(3, 6, 0).

play_rating(4, 0, 7).
play_rating(4, 1, 6).
play_rating(4, 2, 5).
play_rating(4, 3, 4).
play_rating(4, 4, 0).
play_rating(4, 5, 0).

play_rating(5, 0, 8).
play_rating(5, 1, 8).
play_rating(5, 2, 8).
play_rating(5, 3, 8).
play_rating(5, 4, 0).

play_rating(6, 0, 8).
play_rating(6, 1, 8).
play_rating(6, 2, 8).
play_rating(6, 3, 0).

play_rating(7, 0, 8).
play_rating(7, 1, 8).
play_rating(7, 2, 0).

play_rating(8, 0, 8).
play_rating(8, 1, 0).

play_rating(9, 0, 0).






