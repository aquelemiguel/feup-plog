livro('Os Maias').
autor('Eca de Queiroz').
escreveu('Eca de Queiroz', 'Os Maias').
nacionalidade('Eca de Queiroz', portugues).
nacionalidade('Eca de Queiroz', ingles).
tipo('Os Maias', romance).
tipo('Os Maias', ficcao).

tugasromances(X) :-
  autor(X),
  nacionalidade(X, portugues),
  escreveu(X, Y),
  tipo(Y, romance).

ficcaoeoutrotipo(X) :-
  autor(X),
  escreveu(X, Y), % Escreveu 'Os Maias'.
  tipo(Y, W),
  tipo(Y, K),
  W \= K.

% a) escreveu(X, 'Os Maias').
% b) tugasromances(X).
% c) ficcaoeoutrotipo(X).
