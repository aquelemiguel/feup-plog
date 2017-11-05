% TODO: Remove the 'if...else' statement here.

main_menu :-
  nl, write('Select your game mode:'),
  nl, write('  1. Play'),
  nl, write('  2. Rules'),
  nl, write('  3. About'),
  nl, write('  4. Exit'),
  nl, nl,

  read(Input), (
  Input == 1 -> play_menu;
  Input == 2 -> rules_menu;
  Input == 3 -> about_menu;
  Input == 4;

  nl, write('Invalid input!'), nl, main_menu
  ).

play_menu :-
  nl, write('Select your game mode:'),
  nl, write('  1. Player vs Player'),
  nl, write('  2. Player vs AI'),
  nl, write('  3. AI vs AI'),
  nl, write('  4. Exit'), nl, nl,

  read(Input), (
  Input == 1 -> init_game(Game, 1)
  ).

rules_menu :-
  nl, write('Coming soon...'), nl, nl.

about_menu :-
  nl, write('PrOolong was developed by:'),
  nl, write(' - Jose Pedro Borges up201503603'),
  nl, write(' - Miguel Mano Fernandes, up201503538'), nl, nl.

% TODO: Specific printing for each player.
menu_rotate_tile(Orientation, Turns) :-
  write('ROTATE special marker has been triggered on this tile!'), nl,
  write('Which orientation to rotate?'),
  read(Orientation),
  write('How many turns?'),
  read(Turns).

menu_swap_unclaimed(Game, Table1, Table2) :-
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
  menu_swap_unclaimed(Game, Table1, Table2).

menu_swap_mixed(Game, Table1, Table2) :-
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
  menu_swap_mixed(Game, Table1, Table2).


