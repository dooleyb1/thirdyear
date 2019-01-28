% string2fsm(+String, ?TransitionSet, ?FinalStates)
string2fsm([], [], [q0]).
string2fsm([H|T], Trans, [Last]) :-
mkTL(T, [H], [[q0, H, [H]]], Trans, Last).

% mkTL(+More, +LastSoFar, +TransSoFar, ?Trans, ?Last)
mkTL([], L, Trans, Trans, L).
mkTL([H|T], L, TransSoFar, Trans, Last) :-
mkTL(T, [H|L], [[L,

% accept(TransitionSet, FinalStates, IntitialState, String)

% Base case - if initial state is in finalStates accept
accept(_, F, Q, []) :- member(Q, F).

% If a transition from Q to Qn when seeing H exists, accept and try
% to accept T when in state Qn
accept(Transitions, FinalStates, InitialState, [H|T]) :-
  member([InitialState, H, Qn], Transitions),
  accept(Transitions, FinalStates, Qn, T).

% member(X, List)
member(X, [X|_]).
member(X, [_|L]) :- member(X, L).
