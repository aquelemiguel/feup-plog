main_menu :-
  clear_console,
  nl,
  write('      _..,----,.._       __   __       __        __ '), nl,
  write('   .-;\'-.,____,.-\';     |  | |  | |   |  | |\\ | | _ '), nl,
  write('  (( |            |     |__| |__| |__ |__| | \\| |__| '), nl,
  write('   `))            ;     Dominate the tea house.    '), nl,
  write('    ` \\          /     '), nl,
  write('   .-\' `,.____.,\' \'-.    (1) Play   (2) Rulebook     '), nl,
  write('  (     \'------\'     )   (3) About  (4) Exit'), nl,
  write('   `-=..________..--\'     '), nl, nl,

  read(Input), (
  Input == 1 -> gamemode_menu;
  Input == 2 -> rules_menu_page1;
  Input == 3 -> about_menu;
  Input == 4;

  nl, write('Invalid input!'), nl, main_menu
  ).

gamemode_menu :-
  clear_console,
  nl,
  write('      _..,----,.._       __   __       __        __ '), nl,
  write('   .-;\'-.,____,.-\';     |  | |  | |   |  | |\\ | | _ '), nl,
  write('  (( |            |     |__| |__| |__ |__| | \\| |__| '), nl,
  write('   `))            ;     Dominate the tea house.    '), nl,
  write('    ` \\          /     '), nl,
  write('   .-\' `,.____.,\' \'-.    (1) Single Player  (2) Multiplayer     '), nl,
  write('  (     \'------\'     )   (3) Skynet Mode    (4) Back'), nl,
  write('   `-=..________..--\'     '), nl, nl,

  read(Input), (
  Input == 1 -> difficulty_menu_single_player;
  Input == 2 -> init_game(_, 2, _);
  Input == 3 -> difficulty_menu_skynet;
  Input == 4 -> main_menu
  ).

difficulty_menu_single_player :-
  clear_console,
  nl,
  write('      _..,----,.._       __   __       __        __ '), nl,
  write('   .-;\'-.,____,.-\';     |  | |  | |   |  | |\\ | | _ '), nl,
  write('  (( |            |     |__| |__| |__ |__| | \\| |__| '), nl,
  write('   `))            ;     Dominate the tea house.    '), nl,
  write('    ` \\          /     '), nl,
  write('   .-\' `,.____.,\' \'-.    (1) Easy  (2) Normal     '), nl,
  write('  (     \'------\'     )   (3) Back                        '), nl,
  write('   `-=..________..--\'     '), nl, nl,

  read(Input), (
  Input == 1 -> init_game(_, 1, easy);
  Input == 2 -> init_game(_, 1, normal);
  Input == 3 -> gamemode_menu
  ).

difficulty_menu_skynet :-
  clear_console,
  nl,
  write('      _..,----,.._       __   __       __        __ '), nl,
  write('   .-;\'-.,____,.-\';     |  | |  | |   |  | |\\ | | _ '), nl,
  write('  (( |            |     |__| |__| |__ |__| | \\| |__| '), nl,
  write('   `))            ;     Dominate the tea house.    '), nl,
  write('    ` \\          /     '), nl,
  write('   .-\' `,.____.,\' \'-.    (1) Easy  (2) Normal     '), nl,
  write('  (     \'------\'     )   (3) Back                        '), nl,
  write('   `-=..________..--\'     '), nl, nl,

  read(Input), (
  Input == 1 -> init_game(_, 3, easy);
  Input == 2 -> init_game(_, 3, normal);
  Input == 3 -> gamemode_menu
  ).

rules_menu_page1 :-
  clear_console,
  nl,
  write('      _..,----,.._       __   __       __        __ '), nl,
  write('   .-;\'-.,____,.-\';     |  | |  | |   |  | |\\ | | _ '), nl,
  write('  (( |            |     |__| |__| |__ |__| | \\| |__| '), nl,
  write('   `))            ;     Dominate the tea house.    '), nl,
  write('    ` \\          /     '), nl,
  write('   .-\' `,.____.,\' \'-.    (1) Next Page'), nl,
  write('  (     \'------\'     )   (3) Back'), nl,
  write('   `-=..________..--\'     '), nl, nl,

  write('   [Page 1/3]'), nl,
  write('    Welcome!'), nl,
  write('    Oolong is a strategy game designed for two players and based on a japanese tea house, where each player represents
   a different tea maker (black and green) and try to serve as much tea of their brand as possible. Whenever a player serves 5 seats
   on a table, he claims that table. To win a game you need to claim 5 of the 9 tables available.
    Starting the Game: The black player is always first and has to place a piece on the middle table. If playing multiple games, the loser
   of the previous game plays first
    Placing tokens: The space on which a token is placed indicates the table on which the next player will place their next token.'),nl,

  read(Input), (
    Input == 1 -> rules_menu_page2;
    Input == 3 -> main_menu
  ).

rules_menu_page2 :-
  clear_console,
  nl,
  write('      _..,----,.._       __   __       __        __ '), nl,
  write('   .-;\'-.,____,.-\';     |  | |  | |   |  | |\\ | | _ '), nl,
  write('  (( |            |     |__| |__| |__ |__| | \\| |__| '), nl,
  write('   `))            ;     Dominate the tea house.    '), nl,
  write('    ` \\          /     '), nl,
  write('   .-\' `,.____.,\' \'-.    (1) Next Page  (2) Previous Page'), nl,
  write('  (     \'------\'     )   (3) Back'), nl,
  write('   `-=..________..--\'     '), nl, nl,

  write('   [Page 2/3]'), nl,
  write('    The Waiter
    The waiter helps you keep track more easily of where the next play will take place and where the previous play was taken.
    Whenever a player chooses a seat on a table, the waiter will be moved to the table referenced by the play, and to the seat
   indicating where the last player was. For example, if a player is on table 5 and chooses seat 3, the waiter will be moved
   to table 3 and seat 5.'), nl, nl,

  read(Input), (
    Input == 1 -> rules_menu_page3;
    Input == 2 -> rules_menu_page1;
    Input == 3 -> main_menu
  ).

rules_menu_page3 :-
  clear_console,
  nl,
  write('      _..,----,.._       __   __       __        __ '), nl,
  write('   .-;\'-.,____,.-\';     |  | |  | |   |  | |\\ | | _ '), nl,
  write('  (( |            |     |__| |__| |__ |__| | \\| |__| '), nl,
  write('   `))            ;     Dominate the tea house.    '), nl,
  write('    ` \\          /     '), nl,
  write('   .-\' `,.____.,\' \'-.                   (2) Previous Page'), nl,
  write('  (     \'------\'     )   (3) Back'), nl,
  write('   `-=..________..--\'     '), nl, nl,

  write('   [Page 3/3]'), nl,
  write('    Special Markers.
      These are special actions that are triggered whenever a player meets the requirement for them on a specific table. There
    are 8 spread throughout all the tables except the middle one. They are always put at random.
      The MOVEBLACK and MOVEGREEN markers require you to switch a black or green piece(depending on who activates them) from one
    table to another. Both have to be unclaimed. These are activated whenever a player has 3 of their tokens on the table associated.
      WAITERBLACK and WAITERGREEN are markers that require either the black or green player to move the waiter to wherever they choose.
    The next player will have to play where the waiter is located. Activated with 5 pieces.
      SWAPMIXED allows the activating player to swap an unclaimed table with a claimed one. Activated with 5 pieces.
      SWAPUNCLAIMED allows the activating player to swap two unclaimed tables. Activated with 4 pieces.
      ROTATE allows the player to rotate a table clockwise or counterclockwise how many positions they wish. There are two of these
    and each are activated with 4 matching pieces.'), nl, nl,

  read(Input), (
    Input == 2 -> rules_menu_page2;
    Input == 3 -> main_menu
  ).

about_menu :-
  clear_console,
  nl,
  write('      _..,----,.._       __   __       __        __ '), nl,
  write('   .-;\'-.,____,.-\';     |  | |  | |   |  | |\\ | | _ '), nl,
  write('  (( |            |     |__| |__| |__ |__| | \\| |__| '), nl,
  write('   `))            ;     Dominate the tea house.    '), nl,
  write('    ` \\          /     '), nl,
  write('   .-\' `,.____.,\' \'-.     Made with \u2764 by'), nl,
  write('  (     \'------\'     )    Jose Pedro Borges      '), nl,
  write('   `-=..________..--\'     Miguel Mano Fernandes    (4) Back'), nl, nl,

  read(Input), (
    Input == 4 -> main_menu
  ).

/**
  @desc Displays the ROTATE special marker menu.
*/
menu_rotate_tile(Game, Orientation, Turns) :-

  get_gamemode(Game, Gamemode),
  get_turn(Game, Player),

  ((Gamemode = 1, Player = b); Gamemode = 2), % Manual input if it's Multiplayer or the player's turn on Single Player.

  write('ROTATE special marker has been triggered on this tile!'), nl,

  write('Which orientation to rotate?'), nl,
  read(Orientation),
  write('How many turns?'), nl,
  read(Turns).

menu_rotate_tile(Game, Orientation, Turns) :-

  get_gamemode(Game, Gamemode),
  get_turn(Game, Player),

  ((Gamemode = 1, Player = g); Gamemode = 3), % Automatic input if it's Skynet Mode or the bot's turn on Single Player.

  write('ROTATE special marker has been triggered on this tile!'), nl,

  random_between(0, 1, Orientation),
  random_between(1, 9, Turns),

  write('Bot has rotated table!'), nl.

/**
  @desc Displays the SWAPUNCLAIMED special marker menu.
*/
menu_swap_unclaimed(Game, Table1, Table2) :-

  get_gamemode(Game, Gamemode),
  get_turn(Game, Player),
  ((Gamemode = 1, Player = b); Gamemode = 2), % Manual input if it's Multiplayer or the player's turn on Single Player.

  write('SWAPUNCLAIMED special marker has been triggered!'), nl,

  write('Select table #1.'), nl,
  read(Table1), nl,
  check_index_out_of_bounds(Table1),
  check_unclaimed_table(Game, Table1),

  write('Select table #2.'), nl,
  read(Table2), nl,
  check_index_out_of_bounds(Table2),
  check_unclaimed_table(Game, Table2).

menu_swap_unclaimed(Game, Table1, Table2) :-

  get_gamemode(Game, Gamemode),
  get_turn(Game, Player),
  ((Gamemode = 1, Player = g); Gamemode = 3), % Automatic input if it's Skynet Mode or the bot's turn on Single Player.

  write('SWAPUNCLAIMED special marker has been triggered!'), nl,

  write('Select table #1.'), nl,
  random_between(1, 9, Table1),
  check_index_out_of_bounds(Table1),
  check_unclaimed_table(Game, Table1),

  write('Select table #2.'), nl,
  random_between(1, 9, Table2),
  check_index_out_of_bounds(Table2),
  check_unclaimed_table(Game, Table2).

menu_swap_unclaimed(Game, Table1, Table2) :-
  menu_swap_unclaimed(Game, Table1, Table2).

/**
  @desc Displays the SWAPUNCLAIMED special marker menu.
*/
menu_swap_mixed(Game, Table1, Table2) :-

  get_gamemode(Game, Gamemode),
  get_turn(Game, Player),
  ((Gamemode = 1, Player = b); Gamemode = 2), % Manual input if it's Multiplayer or the player's turn on Single Player.

  write('SWAPMIXED special marker has been triggered!'), nl,

  write('Select the CLAIMED table to swap.'), nl,
  read(Table1), nl,
  check_index_out_of_bounds(Table1),
  check_claimed_table(Game, Table1),

  write('Select the UNCLAIMED table to swap.'), nl,
  read(Table2), nl,
  check_index_out_of_bounds(Table2),
  check_unclaimed_table(Game, Table2).

menu_swap_mixed(Game, Table1, Table2) :-

  get_gamemode(Game, Gamemode),
  get_turn(Game, Player),
  ((Gamemode = 1, Player = g); Gamemode = 3), % Automatic input if it's Skynet Mode or the bot's turn on Single Player.

  write('SWAPMIXED special marker has been triggered!'), nl,

  write('Select the CLAIMED table to swap.'), nl,
  random_between(1, 9, Table1),
  check_index_out_of_bounds(Table1),
  check_claimed_table(Game, Table1),

  write('Select the UNCLAIMED table to swap.'), nl,
  random_between(1, 9, Table2),
  check_index_out_of_bounds(Table2),
  check_unclaimed_table(Game, Table2).

menu_swap_mixed(Game, Table1, Table2) :-
  menu_swap_mixed(Game, Table1, Table2).

/**
  @desc Displays the MOVEBLACK special marker menu.
*/
menu_move_black(Game, Table1, Seat1, Table2, Seat2) :-

  get_gamemode(Game, Gamemode),
  get_turn(Game, Player),
  ((Gamemode = 1, Player = b); Gamemode = 2), % Manual input if it's Multiplayer or the player's turn on Single Player.

  write('MOVEBLACK special marker has been triggered!'), nl,
  write('Select table #1.'), nl,
  read(Table1), nl,
  write('Select piece #1.'), nl,
  read(Seat1), nl,
  write('Select table #2.'), nl,
  read(Table2), nl,
  write('Select piece #2.'), nl,
  read(Seat2),

  check_unclaimed_table(Game, Table1),
  check_unclaimed_table(Game, Table2),

  nth1(Table1, Board, TableName1),
  nth1(Table2, Board, TableName2),

  nth1(Seat1, TableName1, SeatName1), SeatName1 = b,
  nth1(Seat2, TableName2, SeatName2), SeatName2 = x.

menu_move_black(Game, Table1, Seat1, Table2, Seat2) :-

  get_gamemode(Game, Gamemode),
  get_turn(Game, Player),
  ((Gamemode = 1, Player = b); Gamemode = 3), % Automatic input if it's Skynet Mode or the bot's turn on Single Player.

  write('MOVEBLACK special marker has been triggered!'), nl,
  random_between(1, 9, Table1),
  random_between(1, 9, Seat1),
  random_between(1, 9, Table2),
  random_between(1, 9, Seat2),

  check_unclaimed_table(Game, Table1),
  check_unclaimed_table(Game, Table2),

  nth1(Table1, Board, TableName1),
  nth1(Table2, Board, TableName2),

  nth1(Seat1, TableName1, SeatName1), SeatName1 = b,
  nth1(Seat2, TableName2, SeatName2), SeatName2 = x.

menu_move_black(Game, Table1, Seat1, Table2, Seat2) :- menu_move_black(Game, Table1, Seat1, Table2, Seat2).

/**
  @desc Displays the MOVEGREEN special marker menu.
*/
menu_move_green(Game, Table1, Seat1, Table2, Seat2) :-

  get_gamemode(Game, Gamemode),
  get_turn(Game, Player),
  ((Gamemode = 1, Player = g); Gamemode = 2), % Manual input if it's Multiplayer or the player's turn on Single Player.

  write('MOVEGREEN special marker has been triggered!'), nl,
  write('Select table #1.'), nl,
  read(Table1), nl,
  write('Select piece #1.'), nl,
  read(Seat1), nl,
  write('Select table #2.'), nl,
  read(Table2), nl,
  write('Select piece #2.'), nl,
  read(Seat2),

  check_unclaimed_table(Game, Table1),
  check_unclaimed_table(Game, Table2),

  nth1(Table1, Board, TableName1),
  nth1(Table2, Board, TableName2),

  nth1(Seat1, TableName1, SeatName1), SeatName1 = g,
  nth1(Seat2, TableName2, SeatName2), SeatName2 = x.

menu_move_green(Game, Table1, Seat1, Table2, Seat2) :-

  get_gamemode(Game, Gamemode),
  get_turn(Game, Player),
  ((Gamemode = 1, Player = g); Gamemode = 3), % Automatic input if it's Skynet Mode or the bot's turn on Single Player.

  write('MOVEGREEN special marker has been triggered!'), nl,
  random_between(1, 9, Table1),
  random_between(1, 9, Seat1),
  random_between(1, 9, Table2),
  random_between(1, 9, Seat2),

  check_unclaimed_table(Game, Table1),
  check_unclaimed_table(Game, Table2),

  nth1(Table1, Board, TableName1),
  nth1(Table2, Board, TableName2),

  nth1(Seat1, TableName1, SeatName1), SeatName1 = g,
  nth1(Seat2, TableName2, SeatName2), SeatName2 = x.

menu_move_green(Game, Table1, Seat1, Table2, Seat2) :- menu_move_green(Game, Table1, Seat1, Table2, Seat2).

move_black_waiter(Game, TableIndex) :-

  get_gamemode(Game, Gamemode),
  get_turn(Game, Player),
  ((Gamemode = 1, Player = b); Gamemode = 2), % Manual input if it's Multiplayer or the player's turn on Single Player.

  write('WAITERBLACK has been activated! Select table where you want to move the waiter.'), nl,
  read(TableIndex), nl.

move_black_waiter(Game, TableIndex) :-

  get_gamemode(Game, Gamemode),
  get_turn(Game, Player),
  ((Gamemode = 1, Player = b); Gamemode = 3), % Automatic input if it's Skynet Mode or the bot's turn on Single Player.

  random_between(1, 9, TableIndex).

move_green_waiter(Game, TableIndex) :-

  get_gamemode(Game, Gamemode),
  get_turn(Game, Player),
  ((Gamemode = 1, Player = g); Gamemode = 2), % Manual input if it's Multiplayer or the player's turn on Single Player.

  write('WAITERGREEN has been activated! Select table where you want to move the waiter.'), nl,
  read(TableIndex), nl.

move_green_waiter(Game, TableIndex) :-

  get_gamemode(Game, Gamemode),
  get_turn(Game, Player),
  ((Gamemode = 1, Player = g); Gamemode = 3), % Automatic input if it's Skynet Mode or the bot's turn on Single Player.

  random_between(1, 9, TableIndex).

table_full_menu(Game, TableIndex, SeatIndex) :-
  get_gamemode(Game, Gamemode),
  Gamemode = 2, % Manual input if it's Multiplayer or the player's turn on Single Player.

  write('Table is full! Select table where you want to play now.'), nl,
  read(TableIndex), nl,

  write('Select the seat.'),
  read(SeatIndex), nl.

table_full_menu_bot(Game, TableIndex, SeatIndex) :-
  get_gamemode(Game, Gamemode),
  Gamemode = 1, % Manual input if it's Multiplayer or the player's turn on Single Player.

  random_between(1, 9, TableIndex),
  random_between(1, 9, SeatIndex).
