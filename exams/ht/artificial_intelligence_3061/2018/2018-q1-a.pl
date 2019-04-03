% Base case - Node is goal
frontierSearch([Node|_]) :- goal(Node).

frontierSearch([Node|Rest]) :-
  findall(Next, arc(Node,Next), Children),      % Find all children connected to node by arc
  add2frontier(Children, Rest, NewFrontier),    % Add nodes children to frontier
  frontierSearch(NewFrontier).                  % Search the new frontier


  % ----------------------------------------------------------------------------
  %                  DEPTH FIRST SEARCH - add2frontier (LIFO)
  % ----------------------------------------------------------------------------

  % Base case, add empty node
  add2frontier([], Rest, Rest).

  add2frontier([H|T], Rest, [H|TRest]) :-     % Recursively add head of child
    add2frontier(T, Rest, TRest).

% ----------------------------------------------------------------------------
%                  BREADTH FIRST SEARCH - add2frontier (LIFO)
% ----------------------------------------------------------------------------

% Base case, add empty node
add2frontier(Children, [], Children).

add2frontier(Children, [H|T], [H|More]) :-    % Reduces Rest of frontier first
  add2frontier(Children, T, More).
