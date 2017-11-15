/**
	CR1 - Funcionamento do Backtracking
**/
r(a, b).
r(a, c).
r(b, a).
r(a, d).

s(b, c).
s(b, d).
s(c, c).
s(d, e).

	% a) X = a, Y = d, Z = e.
	% b) ...

/**
	CR4 - Cálculo de Factorial e Fibonacci
**/
factorial(0, 1).
factorial(1, 1).

factorial(N, Valor) :-
	N > 1,
	NewN is N - 1,
	factorial(NewN, NewValor),
	Valor is N * NewValor.
