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
bot_play_turn_normal(Game, UpdatedGame).

/**
  @desc Bot performs its play on the HARD difficulty.
		On HARD mode, the bot (strongly) takes into account the various outcomes of his plays, but plays special markers randomly.
		If two choices are equally good, it randomly picks one.
*/
bot_play_turn_hard(Game, UpdatedGame).



