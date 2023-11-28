%cores de camiseta
camiseta(azul).
camiseta(amarela).
camiseta(vermelha).
camiseta(branca).
camiseta(verde).

%nomes
nome(fausto).
nome(josue).
nome(sato).
nome(tiago).
nome(vinicius).

%profissao
profissao(advogado).
profissao(economista).
profissao(engenheiro).
profissao(estudante).
profissao(programador).

%idade
idade(22).
idade(24).
idade(26).
idade(27).
idade(32).

%peso
peso(61).
peso(68).
peso(72).
peso(79).
peso(85).

%treinando
treinando(biceps).
treinando(ombro).
treinando(peito).
treinando(perna).
treinando(triceps).

%X está à ao lado de Y
aoLado(X,Y,Lista) :- nextto(X,Y,Lista);nextto(Y,X,Lista).

%X está à esquerda de Y (em qualquer posição à esquerda)
aEsquerda(X,Y,Lista) :- nth0(IndexX,Lista,X), 
                        nth0(IndexY,Lista,Y), 
                        IndexX < IndexY.
                        
%X está à direita de Y (em qualquer posição à direita)
aDireita(X,Y,Lista) :- aEsquerda(Y,X,Lista). 

%X está no canto se ele é o primeiro ou o último da lista
noCanto(X,Lista) :- last(Lista,X).
noCanto(X,[X|_]).

%Z está entre X e Y se é membro da sublista que começa em X e termina em Y
entreOrdenado(Z,X,Y,Lista) :- aDireita(Z, X, Lista),
                              aEsquerda(Z, Y, Lista).

todosDiferentes([]).
todosDiferentes([H|T]) :- not(member(H,T)), todosDiferentes(T).

solucao(ListaSolucao) :- 

    ListaSolucao = [
        colega(Camiseta1, Nome1, Profissao1, Idade1, Peso1, Treinando1),
        colega(Camiseta2, Nome2, Profissao2, Idade2, Peso2, Treinando2),
        colega(Camiseta3, Nome3, Profissao3, Idade3, Peso3, Treinando3),
        colega(Camiseta4, Nome4, Profissao4, Idade4, Peso4, Treinando4),
        colega(Camiseta5, Nome5, Profissao5, Idade5, Peso5, Treinando5)
    ],

    %A pessoa que está treinando Peito está exatamente à esquerda de quem tem 68 quilos.
    aEsquerda(colega(_, _, _, _, _, peito), colega(_, _, _, _, 68, _), ListaSolucao),
    aoLado(colega(_, _, _, _, _, peito), colega(_, _, _, _, 68, _), ListaSolucao),

    %Quem está treinando Tríceps está em algum lugar entre quem tem 32 anos e quem está treinando Bíceps, exatamente nessa ordem.
    entreOrdenado(colega(_, _, _, _, _, triceps), colega(_, _, _, 32, _, _), colega(_, _, _, _, _, biceps), ListaSolucao),

    %Quem está treinando Perna está em uma das pontas.
    noCanto(colega(_, _, _, _, _, perna), ListaSolucao),

    %A pessoa que tem 61 quilos está ao lado de quem está treinando Peito.
    aoLado(colega(_, _, _, _, 61, _), colega(_, _, _, _, _, peito), ListaSolucao),

    %Quem está treinando Tríceps está exatamente à direita da pessoa com a camiseta Amarela.
    aoLado(colega(_, _, _, _, _, triceps), colega(amarela, _, _, _, _, _), ListaSolucao), 
    aDireita(colega(_, _, _, _, _, triceps), colega(amarela, _, _, _, _, _), ListaSolucao),

    %O segundo aparelho está sendo usado pela pessoa de 72 quilos.
    nth0(1, ListaSolucao, colega(_, _, _, _, 72, _)),

    %A pessoa de 79 quilos está no aparelho de uma das pontas.
    noCanto(colega(_, _, _, _, 79, _), ListaSolucao),

    %O Economista pesa 68 quilos.
    member(colega(_, _, economista, _, 68, _), ListaSolucao),

    %A pessoa da camiseta Azul está em algum lugar à esquerda do que tem 27 anos.
    aEsquerda(colega(azul, _, _, _, _, _), colega(_, _, _, 27, _, _), ListaSolucao),

    %Quem está treinando Ombro está ao lado de quem tem 26 anos.
    aoLado(colega(_, _, _, _, _, ombro), colega(_, _, _, 26, _, _), ListaSolucao),

    %O Engenheiro está ao lado de quem tem 32 anos.
    aoLado(colega(_, _, engenheiro, _, _, _), colega(_, _, _, 32, _, _), ListaSolucao),

    %O terceiro aparelho está sendo usado pela pessoa de 26 anos.
    nth0(2, ListaSolucao, colega(_, _, _, 26, _, _)),

    %O mais jovem está em uma das pontas.
    noCanto(colega(_, _, _, 22, _, _), ListaSolucao),

    %O Advogado está de camiseta Branca.
    member(colega(branca, _, advogado, _, _, _), ListaSolucao),

    %O Estudante está treinando Peito.
    member(colega(_, _, estudante, _, _, peito), ListaSolucao),

    %Sato tem 85 quilos.
    member(colega(_, sato, _, _, 85, _), ListaSolucao),

    %Vinicius está em uma das pontas.
    noCanto(colega(_, vinicius, _, _, _, _), ListaSolucao),

    %Josué está usando uma camiseta Amarela.
    member(colega(amarela, josue, _, _, _, _), ListaSolucao),

    %Quem está usando a camiseta Amarela está em algum lugar entre a pessoa de 79 quilos e o Fausto, exatamente nessa ordem.
    entreOrdenado(colega(amarela, _, _, _, _, _), colega(_, _, _, _, 79, _), colega(_, fausto, _, _, _, _), ListaSolucao),

    %Sato está ao lado do Vinicius.
    aoLado(colega(_, sato, _, _, _, _), colega(_, vinicius, _, _, _, _), ListaSolucao),

    %Tiago está em uma das pontas.
    noCanto(colega(_, tiago, _, _, _, _), ListaSolucao),

    %A pessoa de camiseta Amarela está treinando em algum lugar entre o Tiago e o Advogado, exatamente nessa ordem.
    entreOrdenado(colega(amarela, _, _, _, _, _), colega(_, tiago, _, _, _, _), colega(_, _, advogado, _, _, _), ListaSolucao),

    %A pessoa de camiseta Amarela está treinando em algum lugar entre quem está usando a camiseta Verde e o Vinicius, exatamente nessa ordem.
    entreOrdenado(colega(amarela, _, _, _, _, _), colega(verde, _, _, _, _, _), colega(_, vinicius, _, _, _, _), ListaSolucao),

    %Testa todas as possibilidades...
    camiseta(Camiseta1), camiseta(Camiseta2), camiseta(Camiseta3), camiseta(Camiseta4), camiseta(Camiseta5),
    todosDiferentes([Camiseta1, Camiseta2, Camiseta3, Camiseta4, Camiseta5]),
    
    nome(Nome1), nome(Nome2), nome(Nome3), nome(Nome4), nome(Nome5),
    todosDiferentes([Nome1, Nome2, Nome3, Nome4, Nome5]),
    
    profissao(Profissao1), profissao(Profissao2), profissao(Profissao3), profissao(Profissao4), profissao(Profissao5),
    todosDiferentes([Profissao1, Profissao2, Profissao3, Profissao4, Profissao5]),
    
    idade(Idade1), idade(Idade2), idade(Idade3), idade(Idade4), idade(Idade5),
    todosDiferentes([Idade1, Idade2, Idade3, Idade4, Idade5]),
    
    peso(Peso1), peso(Peso2), peso(Peso3), peso(Peso4), peso(Peso5),
    todosDiferentes([Peso1, Peso2, Peso3, Peso4, Peso5]),

    treinando(Treinando1), treinando(Treinando2), treinando(Treinando3), treinando(Treinando4), treinando(Treinando5),
    todosDiferentes([Treinando1, Treinando2, Treinando3, Treinando4, Treinando5]).