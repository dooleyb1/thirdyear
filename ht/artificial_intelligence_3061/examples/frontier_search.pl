% ------------------------------------------------------------
%                  Frontier Search 1
% ------------------------------------------------------------

% Regular search just calls frontier search, makes Node as a list
search(Node) :- frontierSearch([Node]).

% Base case, search for node and node is goal
frontierSearch([Node|_]) :- goal(Node).

% If not goal
frontierSearch([Node|Rest]) :-
  findall(Next, arc(Node,Next), Children),      % Find all arc's from node to child
  add2frontier(Children,Rest,NewFrontier),      % Add children to new frontier for search
  frontierSearch(NewFrontier).                  % Search for the new frontier

% ------------------------------------------------------------
%                  BREADTH FIRST SEARCH (FIFO)
% ------------------------------------------------------------

add2frontier(Children,[],Children).             % children + empty = children

add2frontier(Children,[H|T],[H|More]) :-        % Recursively add from Head of Rest
  add2frontier(Children,T,More).

% ------------------------------------------------------------
%                  DEPTH FIRST SEARCH (LIFO)
% ------------------------------------------------------------

add2frontier([],Rest,Rest).                     % empty + rest = rest

add2frontier([H|T],Rest,[H|TRest]) :-           % Rescursively add from Head of Children
  add2frontier(T,Rest,TRest).


% ------------------------------------------------------------
%                  Depth-First Frontier Search
% ------------------------------------------------------------

fs([[]|_], ).                                   % Search of empty list is true

fs([Node|More],KB) :-
  findall(X,arc(Node,X),L),                     % L = children connected to Node
  append(L,More,NewFrontier),                   % NewFrontier = L + More
  fs(NewFrontier,KB).                           % searchNewFrontier

% ------------------------------------------------------------
%            Depth-First Frontier Search with Cut
% ------------------------------------------------------------

fs([[]|_], ).                                   % Search of empty list is true

fs([[cut|T]|_],KB)) :- fs([T],KB).

fs([Node|More],KB) :-
  Node = [H|_], H \== cut,
  findall(X,arc(Node,X),L),                     % L = children connected to Node
  append(L,More,NewFrontier),                   % NewFrontier = L + More
  fs(NewFrontier,KB).                           % searchNewFrontier
