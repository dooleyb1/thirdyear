% Increment (P1, P2) => P2 is P1++
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
