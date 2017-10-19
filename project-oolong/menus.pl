main_menu :-
  nl, write('Select your game mode:'),
  nl, write('  1. Play'),
  nl, write('  2. Rules'),
  nl, write('  3. About'),
  nl, write('  4. Exit'),
  nl, nl,
  read(Input), (
  Input == 1 -> play_menu, main_menu;
  Input == 2 -> rules_menu, main_menu;
  Input == 3 -> about_menu, main_menu;
  Input == 4;

  nl, write('Invalid input!'), nl, main_menu
  ).

play_menu :-
  nl, write('Select your game mode:'),
  nl, write('  1. Player vs Player'),
  nl, write('  2. Player vs AI'),
  nl, write('  3. AI vs AI'), nl, nl,
  nl, write('  4. Exit'),
  read(Input), (
  Input == 1 -> play_pvp, play_menu;
  Input == 2 -> play_pvc, play_menu;
  Input == 3 -> play_cvc, play_menu;
  Input == 4;

  nl,nl).

  % TODO: Add input handling for this menu.

  play_pvp :-
    nl, write('Coming soon...'), nl, nl.

  play_pvc :-
    nl, write('Coming soon...'), nl, nl.

  play_cvc :-
    nl, write('Coming soon...'), nl, nl.

rules_menu :-
  nl, write('Coming soon...'), nl, nl.

about_menu :-
  nl, write('PrOolong was developed by:'),
  nl, write(' - Jose Pedro Borges up201503603'),
  nl, write(' - Miguel Mano Fernandes, up201503538'), nl, nl.
