homem(joao).
mulher(maria).
mulher(ana).

animal(gato).
animal(tigre).
animal(cao).

jogo(xadrez).
jogo(damas).
desporto(tenis).
desporto(natacao).

mora_em(joao, casa).
mora_em(maria, casa).
mora_em(ana, apartamento).

gosta_de(joao, desporto).
gosta_de(maria, desporto).
gosta_de(maria, jogo).
gosta_de(ana, tenis).
gosta_de(ana, animal).

% a) mora_em(X, apartamento), gosta_de(X, animal).
% b) mora_em(joao, casa), gosta_de(joao, desporto), mora_em(maria, casa), gosta_de(maria, desporto).
% c) gosta_de(X, jogo), gosta_de(X, desporto).
% d) mulher(X), gosta_de(X, tenis), gosta_de(X, tigre).
