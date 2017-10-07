aluno(joao, paradigmas).
aluno(maria, paradigmas).
aluno(joel, lab2).
aluno(joel, estruturas).

frequenta(joao, feup).
frequenta(maria, feup).
frequenta(joel, ist).

professor(carlos, paradigmas).
professor(ana_paula, estruturas).
professor(pedro, lab2).

funcionario(pedro, ist).
funcionario(ana_paula, feup).
funcionario(carlos, feup).

alunodeprofessor(X, Y) :-
  aluno(X, Z),
  professor(Y, Z),
  frequenta(X, W),
  funcionario(Y, W).

deuniversidade(X, Y) :-
  frequenta(X, Y);
  funcionario(X, Y).

% Falta verificação de colega de curso + duplicados.
ecolega(X, Y) :-
  aluno(X, Z), aluno(Y, Z), X \= Y;
  frequenta(X, Z), frequenta(Y, Z), X \= Y;
  funcionario(X, Z), funcionario(Y, Z), X \= Y.

% a) alunodeprofessor(X, Y).
% b) deuniversidade(X, Y).
% c) ecolega(X, Y).
