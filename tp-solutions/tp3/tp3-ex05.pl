% membro(X,L) :- member(X,L).
% membro(X,L) :- append(_, [X|_], L).
last(L,X) :- append(_, [X], L).
