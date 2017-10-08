comprou(joao, honda).
comprou(joao, uno).

ano(honda, 1997).
ano(uno, 1998).

valor(honda, 20000).
valor(uno, 7000).

pode_vender(Pessoa, Carro, Ano_Atual) :-
  comprou(Pessoa, Carro),
  ano(Carro, Ano_Compra),
  Ano_Compra + 10 >= Ano_Atual,
  valor(Carro, Valor),
  Valor < 10000.
