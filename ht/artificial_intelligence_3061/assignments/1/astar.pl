:- dynamic(kb/1).

makeKB(File):- open(File,read,Str),
               readK(Str,K),
               reformat(K,KB),
               asserta(kb(KB)),
               close(Str).

readK(Stream,[]):- at_end_of_stream(Stream),!.
readK(Stream,[X|L]):- read(Stream,X),
                      readK(Stream,L).

reformat([],[]).
reformat([end_of_file],[]) :- !.
reformat([:-(H,B)|L],[[H|BL]|R]) :- !,
                                    mkList(B,BL),
                                    reformat(L,R).
reformat([A|L],[[A]|R]) :- reformat(L,R).

mkList((X,T),[X|R]) :- !, mkList(T,R).
mkList(X,[X]).

initKB(File) :- retractall(kb(_)), makeKB(File).

% -----------------------------------------------------

astar(Node,Path,Cost) :- kb(KB), astar(Node,Path,Cost,KB).

astar(Node, Path, Cost, KB) :-
  InitialFrontier = [ [[Node],0] ],                           % Set the initial frontier to a NodeCost pair e.g [ [[q],0] ]
  astarRecursive(InitialFrontier, Path, Cost, KB).            % Call astarRecursive with this InitialFrontier

% Success Case - Head of Frontier is [] (goal)
astarRecursive(Frontier, EndPath, EndCost, KB) :-
  Frontier = [PathCostPairHead|PathCostPairTail],             % Extract head of Frontier
  PathCostPairHead = [Path, Cost],                            % Split head into path and cost
  goal(Path),                                                 % If the head of Frontier is the goal, end
  EndPath = Path,                                             % EndPath = Goal ([])
  EndCost = Cost.                                             % EndCost = Cost (1)

% Recursive Case - Head of Frontier is not goal
astarRecursive(Frontier, EndPath, EndCost, KB) :-
  Frontier = [PathCostPairHead|PathCostPairTail],             % Extract head of Frontier
  PathCostPairHead = [Path, Cost],                            % Split head into path and cost
  findall(X, arc(PathCostPairHead, X, KB), Children),         % Find all child nodes of PathCostPairHead
  add-to-frontier(PathCostPairTail, Children, NewFrontier),   % Smartly add children to frontier
  astarRecursive(NewFrontier, EndPath, EndCost, KB).          % Search new frontier

% Goal is when [] is head of Frontier
goal([[]|_]).

% Find arc connected to [Path,Cost] pair
arc([[[HeadNode|TailNode]|PathHistory],Cost], NewPathCost, KB) :-
			member([HeadNode|RuleBody], KB),
      append(RuleBody,TailNode, NextNode),
			length(RuleBody, L),
      LengthCost is L + 1,
			TotalCost is LengthCost + Cost,
      NewPathCost = [[NextNode,[HeadNode|TailNode]|PathHistory],TotalCost].

% Heuristic is the length of the given node
heuristic(Node, H) :- length(Node, H).

% Add-to-frontier base case, empty node
add-to-frontier(Frontier, [], Frontier).

% Add a new [PathCostHead|Rest] into Frontier
add-to-frontier(Frontier, [PathCostHead|PathCostRest], NewFrontier) :-
	insert(PathCostHead, Frontier, FrontierResult),
	add-to-frontier(FrontierResult, PathCostRest, NewFrontier).

% Insert base case, empty frontier
insert(PathCost, [], [PathCost]).

% Insert
insert(NewPathCostPair, [PathCostH|PathCostT1], FrontierResult) :-
	(less-than(NewPathCostPair, PathCostH), FrontierResult = [NewPathCostPair, PathCostH|PathCostT1] ;   % If less than explore first, add to Frontier and explore
	insert(NewPathCostPair, PathCostT1, PathCostT2)), FrontierResult = [PathCostH|PathCostT2].        % If more than, explore last

% Compare two frontiers based on heuristics
less-than([[Node1|_],Cost1], [[Node2|_],Cost2]) :-
	heuristic(Node1, H1), heuristic(Node2, H2),
	F1 is Cost1 + H1, F2 is Cost2 + H2,
	F1 =< F2.
