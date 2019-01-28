% Basic idea of a search
search(Node) :- goal(Node).
search(Node) :- arc(Node,Next), search(Next).

% goal(State, String, FinalStates)
goal(Q,[],Final) :- member(Q,Final).

% arc(Node, Next, Transitions)
arc([Q,[H|T]],[Qn,T],Trans) :- member([Q,H,Qn],Trans).

% search(InitialState, String, FinalState, Transitions)
search(Q,S,F, ) :- goal(Q,S,F).

search(Q,S,F,T) :-
  arc([Q,S],[Qn,Sn],T),
  search(Qn,Sn,F,T).

% accept(Transitions, FinalStates, InitialState, String)
accept(T,F,Q,S) :- search(Q,S,F,T).

% ------------------------------------------------------------
% ------------------------------------------------------------

% prove(Node)
prove(Node) :- goal(Node) .
prove(Node) :- arc(Node,Next), prove(Next).

KB = [[i,p,q],[i,r],[p],[r]]

% arc(Node, Next, KnowledgeBase)
arc([H|T],N,KB) :- member([H|B],KB), append(B,T,N).
