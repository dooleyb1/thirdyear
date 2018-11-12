% Write a DCG that accepts strings of the form u2v where u and v are strings
% over the alphabet {0, 1} such that the number of 0’s in u is twice the number
% of 1’s in v. For example,

% | ?- s([0,1,0,1,2,0,0,1,0],L).
% L = [];
% L = [0];
% no

% Count zeros on left first and compare with count of ones on right
s --> left(Count),[2],right(Count).

% Initialize
left(0) --> [].
% If a 1 is found, ignore and continue count of remaining elements
left(Count) --> [1], left(Count).
% If a 0 is found, update count by 1
left(UpdatedCount) --> [0], left(Count), {UpdatedCount is Count + 1}.

% Initialize
right(0) --> [].
% If a 0 is found, ignore and continue count of remaining elements
right(Count) --> [0], right(Count).
% If a 1 is found, update count by 2
right(UpdatedCount) --> [1], right(Count), {UpdatedCount is Count + 2}.
