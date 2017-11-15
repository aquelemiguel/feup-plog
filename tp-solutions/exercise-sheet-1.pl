/**
	RC1 - Prison Break
**/
male('Aldo Burrows').
male('Lincoln Burrows').
male('Michael Scofield').
male('LJ Burrows').

female('Christina Rose Scofield').
female('Lisa Rix').
female('Sara Tancredi').
female('Ella Scofield').

parent('Aldo Burrows', 'Lincoln Burrows').
parent('Christina Rose Scofield', 'Lincoln Burrows').
parent('Aldo Burrows', 'Michael Scofield').
parent('Christina Rose Scofield', 'Michael Scofield').
parent('Lisa Rix', 'LJ Burrows').
parent('Lincoln Burrows', 'LJ Burrows').
parent('Michael Scofield', 'Ella Scofield').
parent('Sara Tancredi', 'Ella Scofield').

	% a) parent(X, 'Michael Scofield').
	% b) parent('Aldo Burrows', X).

/**
	RC2 - Red Bull Air Race
**/
pilot('Lamb').
pilot('Besenyei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').

team('Breitling').
team('Red Bull').
team('Mediterranean Racing Team').
team('Cobra').
team('Matador').

team_member('Lamb', 'Breitling').
team_member('Besenyei', 'Red Bull').
team_member('Chambliss', 'Red Bull').
team_member('MacLean', 'Mediterranean Racing Team').
team_member('Mangold', 'Cobra').
team_member('Jones', 'Matador').
team_member('Bonhomme', 'Matador').

flies('Lamb', 'MX2').
flies('Besenyei', 'Edge540').
flies('Chambliss', 'Edge540').
flies('MacLean', 'Edge540').
flies('Mangold', 'Edge540').
flies('Jones', 'Edge540').
flies('Bonhomme', 'Edge540').

circuit('Istanbul', 9).
circuit('Budapest', 6).
circuit('Porto', 5).

player_win('Jones', 'Porto').
player_win('Mangold', 'Budapest').
player_win('Mangold', 'Istanbul').

team_win(Team, Race) :-
	team_member(Pilot, Team), % Pilot belongs to the team.
	player_win(Pilot, Race). % Pilot won any race.

	% a) player_win(X, 'Porto').
	% b) team_win(X, 'Porto').
	% c) player_win(X, Y), player_win(X, Z), Y \= Z.
	% d) circuit(X, Y), Y > 8.
	% e) flies(X, Y), Y \= 'Edge540'.

/**
	RC3 - Autores de Livros
**/
livro('Os Maias').
autor('Eca de Queiroz').
escreveu('Eca de Queiroz', 'Os Maias').

nacionalidade('Eca de Queiroz', portugues).
nacionalidade('Eca de Queiroz', ingles).

tipo('Os Maias', romance).
tipo('Os Maias', ficcao).

	% a) escreveu(X, 'Os Maias'), autor(X).
	% b) escreveu(X, Y), autor(X), nacionalidade(X, portugues), livro(Y), tipo(Y, romance).
	% c) escreveu(X, Y), livro(Y), tipo(Y, Z), tipo(Y, W), Z \= W.

/**
	RC4 - Comidas e Bebidas
**/
casado(ana, bruno).
casado(barbara, antonio).

gosta(barbara, salmao).
gosta(barbara, peru).
gosta(bruno, solha).
gosta(bruno, 'vinho verde').
gosta(antonio, peru).
gosta(antonio, frango).
gosta(ana, salmao).
gosta(ana, 'vinho verde').

combina('vinho maduro', peru).
combina('vinho verde', salmao).
combina('vinho verde', frango).
combina(cerveja, solha).

	% a) casado(X, Y), gosta(X, 'vinho verde'), gosta(Y, 'vinho verde').
	% b) combina(X, salmao).
	% c) combina('vinho verde', X).

/**
	RC5 - Desportos e Jogos
**/
homem(joao).
mulher(maria).
mulher(ana).
animal(cao).
animal(gato).
animal(tigre).

desporto(natacao).
desporto(tenis).
jogo(xadrez).
jogo(damas).

mora_em(maria, apartamento).
mora_em(joao, apartamento).
mora_em(ana, casa).

gosta_de(maria, cao).
gosta_de(maria, natacao).
gosta_de(joao, tenis).
gosta_de(joao, damas).
gosta_de(ana, tenis).
gosta_de(ana, tigre).

	% a) mora_em(X, apartamento), gosta_de(X, Z), animal(Z).
	% b) mora_em(joao, casa), mora_em(maria, casa), gosta_de(maria, X), desporto(X), gosta_de(joao, Y), desporto(Y).
	% c) gosta_de(X, Y), gosta_de(X, Z), desporto(Y), jogo(Z).
	% d) mulher(X), gosta_de(X, tenis), gosta_de(X, tigre).

/**
	RC6 - Tweety e Silvester
**/
passaro(tweety).
peixe(goldie).
minhoca(molie).
gato(silvester).

gosta2_de(X, Y) :- 
	(passaro(X), minhoca(Y));
	(gato(X), peixe(Y));
	(gato(X), passaro(Y));
	amigo(X, Y).

amigo(eu, Y) :-
	gato(Y), Y = silvester. 

come(X, Y) :-
	gato(X), X = silvester,
	gosta2_de(X, Y).

	% ?- come(silvester, X).

/**
	RC7 - Tweety e Silvester
**/
