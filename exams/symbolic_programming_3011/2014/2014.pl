% Q1 b)

listSum(List, Sum):-listSum2(List,0,Sum).

listSum2([],Sum,Sum).
listSum2([H|T],X,Sum):-NewSum is H+X, listSum2(T,NewSum,Sum).

% Q1 c)

listProd(List,Prod) :- listProd2(List,1,Prod).

listProd2([], Prod, Prod).
listProd2([H|T], X, Prod):- NewProd is H*X, listProd2(T, NewProd, Prod).

% Q1 d)

list2N(0, []).
list2N(N, [N|T]):-
  integer(N),
  N>=0,
  NewN is N-1,
  list2N(NewN, T).

% Q1 e)

nonInc1([]).
nonInc1([_]).
nonInc1([A,B|T]) :- A >= B, nonInc1([B|T]).

% Q2 a)

subset([],_).
subset([H|T],L):- member(H,L), subset(T,L).

% Q2 b)

setEq(L1,L2):- subset(L1,L2), subset(L2,L1).

% Q2 c)

setEq2(L1,L2):- setof(X,member(X,L1),Z), setof(Y,member(Y,L2),Z).

% Q2 d)

nonmember(X,L):- \+ member(X,L).

% Q2 e)

setInt(L1,L2,L3):- append(L1,L2,LU), setEq(LU,L3).

% Q2 f)

setInt2(L1,L2,L3):-
  setof(X,member(X,L1),A1),
  setof(Y,member(Y,L2),A2),
  append(A1,A2,L3).


memberOfBoth(X,L1,L2):- member(X,L1), member(X,L2).

% Q2 g)

if(A,B,C):- A, !, B; C.

% Q2 h)

maxHead(L1,L2):- maxHead([],L1,L2).

maxHead(L1,[H|T],L3):- isMax(H,T), append([H|L1],T,L3).
maxHead(L1,[H|T],L3):- append(L1,[H],X), maxHead(X,T,L3).

isMax(_,[]).
isMax(X,[H|T]):- X>=H, isMax(X,T).
