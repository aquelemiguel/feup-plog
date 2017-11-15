passaro(tweety).
peixe(goldie).
minhoca(molie).
gato(silvester).

gosta(passaro, minhoca).
gosta(gato, peixe).
gosta(gato, passaro).
gosta(amigo, amigo).

amigo(eu, gato).

come(X, Y) :- gato(X), gosta(gato, Y).

% a) come(silvester, Y).
