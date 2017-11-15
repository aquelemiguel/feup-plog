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
	RC7 - Programação e Erros
**/
traduza(1, integer_overflow).
traduza(2, divisao_por_zero).
traduza(3, id_desconhecido).

traduza(Codigo, Significado) :- % Alternatively...
	Codigo = 1 -> Significado = integer_overflow;
	Codigo = 2 -> Significado = divisao_por_zero;
	Codigo = 3 -> Significado = id_desconhecido.

/**
	RC8 - Cargos e Chefes
**/
cargo(tecnico, rogerio).
cargo(tecnico, ivone).

cargo(engenheiro, daniel).
cargo(engenheiro, isabel).
cargo(engenheiro, oscar).
cargo(engenheiro, tomas).

cargo(supervisor, luis).
cargo(supervisor_chefe, sonia).
cargo(secretaria_exec, laura).
cargo(diretor, santiago).

chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, diretor).
chefiado_por(secretaria_exec, diretor).

	% a) O cargo que chefia o técnico é chefiado por quem?
	% b) Se a Ivone for chefiada por um técnico, imprimir todos os cargos.
	% c) Imprime duas vezes os supervisores.
	% d) Quem é chefiado por um supervisor ou supervisor chefe?
	% e) Qual o cargo, exceto o da Carolina, chefiado por um diretor?

/**
	RC9 - Alunos e Professores
**/
aluno(joao, paradigmas).
aluno(maria, paradigmas).
aluno(joel, lab2).
aluno(joel, estruturas).

frequenta(joao, feup).
frequenta(maria, feup).
frequenta(joel, ist).

professor(carlos, paradigmas).
professor(ana_paula, paradigmas).
professor(pedro, lab2).

funcionario(pedro, ist).
funcionario(ana_paula, feup).
funcionario(carlos, feup).

	% a)
	alunos_de_professor(Professor, Aluno) :-
		aluno(Aluno, Cadeira),
		frequenta(Aluno, Faculdade),
		professor(Professor, Cadeira),
		funcionario(Professor, Faculdade).

	% b)
	frequenta_uni(Universidade, Pessoa) :-
		frequenta(Pessoa, Universidade);
		funcionario(Pessoa, Universidade).

	% c)
	colega_de(Pessoa_1, Pessoa_2) :-
		((aluno(Pessoa_1, Cadeira), aluno(Pessoa_2, Cadeira));
		(frequenta(Pessoa_1, Uni), frequenta(Pessoa_2, Uni));
		(funcionario(Pessoa_1, Uni), funcionario(Pessoa_2, Uni))),
		Pessoa_1 \= Pessoa_2.

/**
	RC10 - Carros e Valores
**/
comprou(joao, honda).
comprou(joao, uno).

ano(honda, 1997).
ano(uno, 1998).

valor(honda, 20000).
valor(uno, 7000).

	% a)
	pode_vender(Pessoa, Carro, AnoAtual) :-
		comprou(Pessoa, Carro),
		ano(Carro, AnoCompra),
		AnoIntervalo is AnoAtual - AnoCompra,
		AnoIntervalo =< 10,

		valor(Carro, Valor),
		Valor < 10000. 
