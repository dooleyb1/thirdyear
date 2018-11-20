% q1 c)

% For x to be able to fly it must be a bird and not a penguin
fly(X) :- bird(X), \+ penguin(X).
