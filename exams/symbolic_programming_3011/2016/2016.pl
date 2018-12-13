% Q1 b) isSet

isSet([]).
isSet([H|T]):- nonMember(H, T), isSet(T).

nonMember(_, []).
nonMember(X, [H|T]):- X\=H, nonMember(X, T).

% Q1 b) Alternative

isSetAlt(List) :-  setof(X, member(X, List), List).

% Q1 c) moreThanOne

moreThanOne(List):- setof(X, member(X, List), SetList), length(SetList, N), N>1.

% Q1 d) moreThan

moreThan(List, Num) :- setof(X, member(X, List), SetList), length(SetList, N), N>Num.

% Q2 a) i) factorial non-tail recursive

fac(0, 1).
fac(N, Factorial):-
  N>0,
  LowerN is N-1,
  fac(LowerN, LowerFactorial),
  Factorial is LowerFactorial * N.

% Q2 a) i) fatcorial tail recursive

fac(N, Factorial):- tailFac(N, 1, Factorial).

tailFac(0, Fac, Fac).
tailFac(N, Acc, Fac):-
  N>0,
  LowerN is N-1,
  NewAcc is Acc*N,
  tailFac(LowerN, NewAcc, Fac).

% Q2 b) i) fibonacci non-tail recursive

fib(0, 0).
fib(1, 1).
fib(N, Fibonnacci):-
  N>1,
  LowerN is N-1,
  LowerN2 is N-2,
  fib(LowerN, PR1),
  fib(LowerN2, PR2),
  Fibonnacci is PR1+ PR2.

% Q2 b) ii) fibonacci tail recursive

tailFib(N, Fibonnacci):- fibAcc(N, 0, 1, Fibonnacci).

fibAcc(0, _, Fib, Fib).
fibAcc(N, A, B, Fib):-
  N>0,
  NewB is B+A,
  LowerN is N-1,
  fibAcc(LowerN, B, NewB, Fib).
