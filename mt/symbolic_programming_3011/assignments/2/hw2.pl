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

% Write a DCG that outputs strings:
%
% [Col1,Nat1,Pet1, Col2,Nat2,Pet2, Col3,Nat3,Pet3]
%
% Such that:
%
%   Nationalities ->  [english, spanish, japanese]
%   Pets -> [jaguar, snail, zebra]

% Declare person definition and conditions
s --> person(Colour1, Nationality1, Pet1), person(Colour2, Nationality2, Pet2), person(Colour3, Nationality3, Pet3),
        {Colour1 \== Colour2, Colour1 \== Colour3, Colour2 \== Colour3,
         Nationality1 \== Nationality2, Nationality1 \== Nationality3, Nationality2 \== Nationality3,
         Pet1 \== Pet2, Pet1 \== Pet3, Pet2 \== Pet3}.

person(Colour, Nationality, Pet) --> colour(Colour), nationality(Nationality), pet(Pet).

% Colour options
colour('red')   --> [red].
colour('blue')  --> [blue].
colour('green') --> [green].

% Nationality options
nationality('english')  --> [english].
nationality('spanish')  --> [spanish].
nationality('japanese') --> [japanese].

% Pet options
pet('jaguar') --> [jaguar].
pet('snail')  --> [snail].
pet('zebra')  --> [zebra].

% Write a DCG that given a non-negative integer Sum, accepts lists of integers
%  ≥ 1 that add up to Sum. For example:
%
%   | ?- s(3,L,[]).
%   L = [3];
%   L = [2,1];
%   L = [1,2];
%   L = [1,1,1];
% no

% mkList predicate that makes list of descending numbers from N to 1
mkList(0, []).
mkList(N, [N|T]) :- N > 0, X is N-1, mkList(X, T).

% Sum of 0 is empty list
s(0) --> [].
% Sum to N
s(N) --> {mkList(N, DescList), member(Item, DescList), Remainder is N-Item}, [Item], s(Remainder).
