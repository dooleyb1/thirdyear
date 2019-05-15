% Q1 c) split

split(Number, List, Small, Big) :-
  member(Number, List),
  isNumberList(List),
  splitList(Number,List,[],[],Small,Big).

splitList(_, [], Small, Big, Small, Big).
splitList(Number, [H|T], SmallAcc, BigAcc, Small, Big) :-
  (H < Number, append([H], SmallAcc, NewSmallAcc), splitList(Number, T, NewSmallAcc, BigAcc, Small, Big));
  (H > Number, append([H], BigAcc, NewBigAcc), splitList(Number, T, SmallAcc, NewBigAcc, Small, Big));
  splitList(Number, T, SmallAcc, BigAcc, Small, Big).

isNumberList([]).
isNumberList([H|T]) :- number(H), isNumberList(T).

% Q1 d) sumOfPowers

sumOfPowers(N,SoP):- sOP(N, 0, SoP).

sOP(0, SoP, SoP).
sOP(N, Acc, SoP):-
  N>0,
  NewAcc is Acc + N**N,
  LowerN is N-1,
  sOP(LowerN, NewAcc, SoP).

% Q2 a) member

member(X, [X|_]):- !.
member(X, [H|T]):- H\=X,  member(X, T).

% Q2 c) last

last(X, [X]) :- !.
last(X, [_|T]) :- last(X, T).

% Q2 d) multiple

multiple(X, List):-
  findall(C, (member(C, List), X=C), XList),
  length(XList, N), N>1.

% Q2 e) next

next(A, B, [A, B|_]).
next(A, B, [_|T]):- next(A,B,T).
