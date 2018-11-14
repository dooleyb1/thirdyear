% Verify all of A and B are numbers, and that A has elements less than B
lessSome(A,B) :- allNumbers(A), allNumbers(B), hasLessThan(A,B).

% Recursively reduce to empty list checking for number(H)
allNumbers([]) :- true.
allNumbers([H|T]) :- number(H), allNumbers(T).

% If reduced to empty list before true, false
hasLessThan([], _) :- false.
hasLessThan(_, []) :- false.

% Recursively compare the head of L1 with every element in list 2
hasLessThan([L1Head|_], List2):- lessThan(L1Head, List2).
% If no solution for head, call again with tail
hasLessThan([_|L1Tail], List2):- hasLessThan(L1Tail, List2).


lessThan(L1H,[L2H|_]) :- L1H < L2H.
lessThan(L1H,[_|L2T])  :-  lessThan(L1H,L2T).
