:- use_module(library(clpfd)).
:- use_module(library(lists)).

% IPLR #1 - Problema do Quadrado Mágico NxN
magic_square_3x3(Vars) :-
	Vars = [A1,A2,A3,A4,A5,A6,A7,A8,A9],
	domain(Vars, 1, 9),

	all_distinct(Vars),
	Sum is (9+1)*3//2,

	A1+A2+A3 #= Sum, A4+A5+A6 #= Sum, A7+A8+A9 #= Sum, % Grid lines.
	A1+A4+A7 #= Sum, A2+A5+A8 #= Sum, A3+A6+A9 #= Sum, % Grid columns.
	A1+A5+A9 #= Sum, A3+A5+A7 #= Sum, % Grid diagonals.

	labeling([], Vars).

magic_square_4x4(Vars) :-
	Vars = [A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16],
	domain(Vars, 1, 16),

	all_distinct(Vars),
	Sum is (16+1)*4//2,

	A1+A2+A3+A4 #= Sum, A5+A6+A7+A8 #= Sum, A9+A10+A11+A12 #= Sum, A13+A14+A15+A16 #= Sum,
	A1+A5+A9+A13 #= Sum, A2+A6+A10+A14 #= Sum, A3+A7+A11+A15 #= Sum, A4+A8+A12+A16 #= Sum,
	A1+A6+A11+A16 #= Sum, A4+A7+A10+A13 #= Sum,

	labeling([], Vars).

% IPLR #6 - Soma e Produto
sum_and_product(A,B,C) :-
	domain([A,B,C], 1, 1000), % Arbitrary upper limit.

	A * B * C #= A + B + C,
	C #>= B, B #>= A, % Removes symmetric results.
	labeling([], [A,B,C]).

% IPLR #7 - Peru Assado
roasted_turkey(Price) :-
	domain([Thousands, Units], 0, 9),

	72 * Price #= Thousands * 1000 + 670 + Units,
	labeling([], [Price]).

% IPLR #8 - O Puto na Mercearia
kid_at_grocery_store(Rice, Potatoes, Spaghetti, Tuna) :-
	Products = [Rice, Potatoes, Spaghetti, Tuna],
	domain(Products, 1, 1000),

	Potatoes #>= Tuna, % Potatoes are pricier than the tuna can.
	Tuna #>= Rice, % Tuna is pricier than rice.
	minimum(Spaghetti, Products), % Spaghetti is the cheapest.

	sum(Products, #=, 711),
	Rice * Potatoes * Spaghetti * Tuna #= 711000000, % Obnoxious number because of proportionality.

	labeling([], Products).





	
