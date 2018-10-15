% Increment (P1, P2) => P2 = P1++
% ------------------------------------------
% 1) Increment of 0 is 1
% 2) Increment of X0 is X1
% 3) Increment of X1 is Y0 with Y = (incr X)
incr(null, f1(null)).
incr(f0(X), f1(X)).
incr(f1(X), f0(Y)) :- incr(X, Y).


% Legal (P) => P is a valid binary number
% ------------------------------------------
% 1) 0 is always legal
% 2) If X is to be legal X-- should eventually reach 0
legal(f0(null)).
legal(X) :- legal(Y) , incr(Y, X).


% incrR (X, Y) => Y = X++ (s.t X is valid)
% ------------------------------------------
% 1) Increment of X is Y (verify that X is legal first)
incrR(X, Y) :- legal(X) , incr(X, Y).


% add (P1, P2, P3) => P3 = P1 + P2
% ------------------------------------------
% recursively subtract from P1 and add to P2 until P1 is 0
%
% 1) 0 + X is X
% 2) X + 0 is X
% 3) P3 = P1 + P2
%     - Z = P1--
%     - Q = P2 ++
%     - P3 = Z + Q (until Z or Q is 0)

add(f0(null),X,X).
add(X,f0(null),X).
add(P1,P2,P3) :- incr(Z,P1),
                 incr(P2,Q),
                 add(Z,Q,P3).


% mult (P1, P2, P3) => P3 = P1 * P2
% ------------------------------------------
% recursively add P1 to itself P2 times
%
% 1) call mult(P1, P2, Sum, Result) with Sum=0
% 2) if P2 = 0, return Sum
% 3) if P1 = 0, return Sum
% 4) P3 = P1 * P2 (recursively add P1 to P1 P2 times)
%     - A = P2 --
%     - Sum += P1
%     - P3 = P1 + P1 (until P2 or P1 is 0)

mult(P1, P2, P3) :- mult(P1, P2, f0(null), P3).
mult(P1, f0(null), Sum, Sum).
mult(f0(null), P2, Sum, Sum).

mult(X, Y, Sum, Z) :- incr(A, Y),			  % A = P2--
                    	add(X, Sum, B),		% Sum+=X
                    	mult(X, A, B, Z). % recursive call to mult


% revers (P, RevP) => RevP = reverse(P)
% ------------------------------------------
% 1) call revers(P, Acc, RevP) with Acc=0
% 2) if P = null, RevP = Acc
% 3) if P.outer() == f0 -> X.add(f0)
% 4) if P.outer() == f1 -> X.add(f1)

revers(P, RevP) :- revers(P, null, RevP).
revers(null, RevP, RevP).
revers(f0(P), X, RevP) :- revers(P, f0(X), RevP).
revers(f1(P), X, RevP) :- revers(P, f1(X), RevP).


% normalize (P, Pn) => Pn = normalize(P)
% ------------------------------------------
% 1) normalize(null) -> f0(null)
% 2) normalize(f0(null)) -> f0(null)
% 3) normalize(f1(null)) -> f1(null)
% 4) Pn = reverse(Y) s.t X = reverse(P), Y = remozeZeros(X)

normalize(null,f0(null)).
normalize(f0(null),f0(null)).
normalize(f1(null),f1(null)).

normalize(P, Pn) :- revers(P, X),
                  	removeZeros(X, Y),
                  	revers(Y, Pn).

removeZeros(null, null).
removeZeros(f1(X), f1(X)).
removeZeros(f0(X), Y) :- removeZeros(X, Y).

% test add inputting numbers N1 and N2
testAdd(N1,N2,T1,T2,Sum,SumT) :- numb2pterm(N1,T1), numb2pterm(N2,T2),
                                 add(T1,T2,SumT), pterm2numb(SumT,Sum).

% test mult inputting numbers N1 and N2
testMult(N1,N2,T1,T2,N1N2,T1T2) :- numb2pterm(N1,T1), numb2pterm(N2,T2),
                                  mult(T1,T2,T1T2), pterm2numb(T1T2,N1N2).
% test revers inputting list L
testRev(L,Lr,T,Tr) :- ptermlist(T,L), revers(T,Tr), ptermlist(Tr,Lr).
% test normalize inputting list L
testNorm(L,T,Tn,Ln) :- ptermlist(T,L), normalize(T,Tn), ptermlist(Tn,Ln).
% make a pterm T from a number N    numb2term(+N,?T)
numb2pterm(0,f0(null)).
numb2pterm(N,T) :- N>0, M is N-1, numb2pterm(M,Temp), incr(Temp,T).
% make a number N from a pterm T  pterm2numb(+T,?N)
pterm2numb(null,0).
pterm2numb(f0(X),N) :- pterm2numb(X,M), N is 2*M.
pterm2numb(f1(X),N) :- pterm2numb(X,M), N is 2*M +1.
% reversible  ptermlist(T,L)
ptermlist(null,[]).
ptermlist(f0(X),[0|L]) :- ptermlist(X,L).
ptermlist(f1(X),[1|L]) :- ptermlist(X,L).
