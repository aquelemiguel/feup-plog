mulher(maria).
mulher(ana).

homem(joao).

animal(cao).
animal(gato).
animal(tigre).

jogo(xadrez).
jogo(damas).

desporto(tenis).
desporto(natacao).

mora_em(maria, casa).
mora_em(joao, casa).
mora_em(ana, apartamento).

gosta_de(ana, gato).
gosta_de(maria, gato).
gosta_de(maria, tigre).
gosta_de(maria, tenis).
gosta_de(joao, tenis).
gosta_de(ana, natacao).
gosta_de(joao, damas).

% Suficiente, ou é preciso criar regra para apenas aparecer 'Ana'?
% a) mora_em(X, apartamento), gosta_de(X, Y), animal(Y).
% b) 
