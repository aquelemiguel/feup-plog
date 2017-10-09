pilot(lamb).
pilot(besenyei).
pilot(chambliss).
pilot(maclean).
pilot(mangold).
pilot(jones).
pilot(bonhomme).

team(lamb, breitling).
team(besenyei, redbull).
team(chambliss, redbull).
team(maclean, mrt).
team(mangold, cobra).
team(jones, matador).
team(bonhomme, matador).

plane(lamb, mx2).
plane(besenyei, edge540).
plane(chambliss, edge540).
plane(maclean, edge540).
plane(mangold, edge540).
plane(jones, edge540).
plane(bonhomme, edge540).

circuit(istanbul).
circuit(budapest).
circuit(porto).

winner(jones, porto).
winner(mangold, budapest).
winner(mangold, istanbul).

gates(istanbul, 9).
gates(budapest, 6).
gates(porto, 5).

teamwin(X,Z) :- winner(Y,Z), team(Y,X).
winmorethanone(X) :- winner(X,Y), winner(X,Z), Y \= Z.

% a) winner(X, porto).
% b) teamwin(X, porto).
% c) winmorethanone(X).
% d) gates(X,Y), Y>8.
% e) plane(X,Y), Y \= edge540.
