% Teste #2 2016/2017
:- use_module(library(lists)).
:- use_module(library(clpfd)).

% Pergunta #1
p1(L1, L2) :-
	gen(L1, L2), test(L2).

gen([], []).
gen(L1, [X|L2]) :-
	select(X, L1, L3), gen(L3, L2).

test([_,_]).
test([X1,X2,X3|Xs]) :-
	(X1 < X2, X2 < X3; X1 > X2, X2 > X3),
	test([X2,X3|Xs]).

	%	O predicado gera uma permutação dos elementos da lista L1 em ordem crescente
	%	e decrescente. Caso haja pelo menos dois números iguais, falha.
	%	Sucede se L2 seja uma permutação ordenada de L1.
	%
	%	A sua eficiência é limitada, pois a pesquisa é do tipo "generate and test", em
	%	vez de utilizar técnicas de consistência do tipo "constrain and generate".

% Pergunta #2
p2(L1, L2) :-
	length(L1, N), length(L2, N),

	pos(L1, L2, Is),
	all_distinct(Is),

	labeling([], Is),
	test(L2).

pos([], _, []).
pos([X|Xs], L2, [I|Is]) :-
	nth1(I, L2, X),
	pos(Xs, L2, Is).

	%	"As variáveis de domínio estão a ser instanciadas antes da fase de pesquisa e nem
	%	todas as restrições foram colocadas antes da fase da pesquisa."

% Pergunta #3
p3(L1, L2) :-
	length(L1, N), length(L2, N), length(Is, N),
	domain(Is, 1, N),

	all_distinct(Is), % Primeiro restringir, depois gerar, para eficiência máxima.
	ensure(L1, L2, Is),
	labeling([], L2).

ensure(_, [_,_], [_,_]).
ensure(L1, [X1,X2,X3|Xs], [I1,I2,I3|Is]) :-
	X1 #< X2 #/\ X2 #< X3 % Ordem crescente.
	#\/
	X1 #> X2 #/\ X2 #> X3,
	element(I1, L1, X1), element(I2, L1, X2), element(I3, L1, X3),
	ensure(L1, [X2,X3|Xs], [I2,I3|Is]).

% Pergunta #4 - Versão Receitas
sweet_recipes(MaxTime, NEggs, RecipeTimes, RecipeEggs, Cookings, Eggs) :-
	length(RecipeTimes, NRecipes),
	length(Cookings, 3), % O cozinheiro quer fazer exatamente 3 pratos.
	domain(Cookings, 1, NRecipes),

	all_distinct(Cookings), % Não há receitas repetidas.
	ensure_no_exceed_time(Cookings, RecipeTimes, RequiredTime),
	RequiredTime #=< MaxTime, % O tempo de todas as receitas somado =< tempo disponível.

	ensure_no_exceed_eggs(Cookings, RecipeEggs, Eggs),
	Eggs #=< NEggs, % Os ovos de todas as receitas somadas =< inventário de ovos.

	labeling(maximize(Eggs), Cookings).

ensure_no_exceed_time([], _, 0).
ensure_no_exceed_time([H|T], RecipeTimes, RequiredTime) :-
	ensure_no_exceed_time(T, RecipeTimes, TempRequiredTime),

	element(H, RecipeTimes, Time), % Extrai quantidade de tempo desta receita.
	RequiredTime #= TempRequiredTime + Time.

ensure_no_exceed_eggs([], _, 0).
ensure_no_exceed_eggs([H|T], RecipeEggs, RequiredEggs) :-
	ensure_no_exceed_eggs(T, RecipeEggs, TempRequiredEggs),

	element(H, RecipeEggs, Eggs), % Extrai quantidade de ovos desta receita.
	RequiredEggs #= TempRequiredEggs + Eggs.

% Pergunta #4 - Versão Constrói
constroi(NEmb, Orcamento, EmbPorObjeto, CustoPorObjeto, EmbUsadas, Objetos) :-
	length(EmbPorObjeto, NObjetos),
	length(Objetos, 4), % O Sancho quer fazer exatamente 4 objetos diferentes.
	domain(Objetos, 1, NObjetos),

	all_distinct(Objetos), % Não há projetos repetidos.
	restringir_embalagens(Objetos, EmbPorObjeto, EmbUsadas),
	EmbUsadas #=< NEmb, % As embalagens de todos os projetos somadas =< embalagens disponíveis.

	restringir_orcamento(Objetos, CustoPorObjeto, CustoNecessario),
	CustoNecessario #=< Orcamento, % Custo de todos os projetos =< orçamento.

	labeling([maximize(EmbUsadas)], Objetos).

restringir_embalagens([], _, 0).
restringir_embalagens([H|T], EmbPorObjeto, EmbUsadas) :-
	restringir_embalagens(T, EmbPorObjeto, TempEmbUsadas),

	element(H, EmbPorObjeto, Embalagens),
	EmbUsadas #= TempEmbUsadas + Embalagens.

restringir_orcamento([], _, 0).
restringir_orcamento([H|T], CustoPorObjeto, CustoNecessario) :-
	restringir_orcamento(T, CustoPorObjeto, TempCustoNecessario),

	element(H, CustoPorObjeto, Custo),
	CustoNecessario #= TempCustoNecessario + Custo.

% Pergunta #5 - Versão Presentes
embrulha(Rolos, Presentes, RolosSelecionados) :-
	length(Presentes, NPresentes),
	length(Rolos, NRolos),
	length(RolosSelecionados, NPresentes),
	domain(RolosSelecionados, 1, NRolos),

	return_machines(Rolos, 1, Machines), % Declara as machines (rolos).
	return_tasks(Presentes, RolosSelecionados, Tasks), % Declara as tasks (presentes).

	cumulatives(Tasks, Machines, [bound(upper)]),
	labeling([], RolosSelecionados).

return_machines([], _, []).
return_machines([H|T], Index, Machines) :-
	NextIndex is Index + 1,
	return_machines(T, NextIndex, TempMachines),

	% Uma machine precisa de um índice (incremental) e recursos (quantidade de papel).
	append(TempMachines, [machine(Index, H)], Machines).

return_tasks([], [], []).
return_tasks([HP|TP], [HS|TS], Tasks) :-
	return_tasks(TP, TS, TempTasks),

	% Uma task precisa de Ti, duração, Tf (desprezáveis), recursos (papel necessário) e machine associada.
	append(TempTasks, [task(0, 1, 1, HP, HS)], Tasks).

% Pergunta #5 - Versão Prateleiras
cut(Shelves, Boards, SelectedBoards) :-
	length(Shelves, NShelves),
	length(Boards, NBoards),
	length(SelectedBoards, NShelves),
	domain(SelectedBoards, 1, NBoards),

	return_machines(Boards, 1, Machines), % Declara as machines (tábuas).
	return_tasks(Shelves, SelectedBoards, Tasks), % Declara as tasks (prateleiras).

	cumulatives(Tasks, Machines, [bound(upper)]),
	labeling([], SelectedBoards).

