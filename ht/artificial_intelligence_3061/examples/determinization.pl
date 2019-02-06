% A fsm [Trans, Final, Q0] such that for all [Q,X,Qn] and [Q,X,Qn0] in Trans, Qn = Qn0

arcD(NodeList,NextList) :- setof(Next, arcLN(NodeList,Next), NextList).

arcLN(NodeList,Next) :- member(Node,NodeList), arc(Node,Next).

goalD(NodeList) :- member(Node,NodeList), goal(Node).

searchD(NL) :- goalD(NL);
(arcD(NL,NL2), searchD(NL,NL2)).

search(Node) :- searchD([Node]).
