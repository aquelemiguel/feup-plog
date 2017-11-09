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
	
	rate_play(Game, SeatIndex, Rating),
	append(Ratings, Rating, NewRatings),

	NewIndex is SeatIndex + 1,

	return_play_ratings(Game, NewIndex, NewRatings).

/**
  @desc
*/
rate_play(Game, SeatIndex, Rating) :-
	
	validate_move(Game, SeatIndex),

	get_turn(Game, Player), Player = b,

	get_board(Game, Board),
	nth1(SeatIndex, Board, Table),
	count(g, Table, CountG), CountG = 0,

	Rating is 5.


rate_play(Game, SeatIndex, Rating) :- Rating is 0. % If the move fails to validate.
	



