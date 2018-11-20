% Length of a list - no accumulator
list_length([]     , 0 ).
list_length([_|Xs] , L ) :- list_length(Xs,N) , L is N+1 .

% Length of a list - with accumulator
acc_len([], Acc, Acc).
acc_len([_|T], OldAcc, Length) :-
  NewAcc is OldAcc +1,
  acc_len(T, NewAcc, Length).

% Max element in a list - with accumulator
accMax([H|T], Acc, Max) :-
  H>Acc,
  accMax(T, H, Max).

accMax([H|T], Acc, Max) :-
  H<=Acc,
  accMax(T, Acc, Max).

% Append to a list
append([], L, L).
append([H|L1], L2, [H|L3]) :- append(L1, L2, L3)

% Reverse a list - no accumulator
reverse([], []).
reverse([H|T], R) :- reverse(T, RT), append(RT, [H], R).

% Reverse a list - with accumulator
accReverse([], L, L).
accReverse([H|T], Acc, Rev) :- accReverse(T, [H|Acc], Rev).
