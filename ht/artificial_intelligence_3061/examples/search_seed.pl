% Search from start for target with seed X
breadth1st(Start, Found, Seed, Target) :- fsB([Start], Found, Seed, Target).

% ------------------------------------------------------------
%                  Breadth First Search
% ------------------------------------------------------------

fsB([Node|_], Node, _, Target) :- goal(Node, Target).      % Base case, check if goal

fsB([Node|Rest], Found, Seed, Target) :-                   % Otherwise
  findall(Next, arc(Node, Next, Seed), Children),          % Find all children with matched seed
  append(Rest, Children, NewF),                            % NewF = chilren + rest
  fsB(NewF, Found, Seed, Target).

% ------------------------------------------------------------
%                  Depth First Search
% ------------------------------------------------------------

fsD([Node|_], Node, _, Target) :- goal(Node, Target).      % Base case, check if goal

fsD([Node|Rest], Found, Seed, Target) :-                   % Otherwise
  findall(Next, arc(Node, Next, Seed), Children),          % Find all children with matched seed
  append(Children, Rest, NewF),                            % NewF = rest + children
  fsD(NewF, Found, Seed, Target).
