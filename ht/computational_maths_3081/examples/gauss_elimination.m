A = [4 -2 -3 6;
     -6 7 6.5 -6;
     1 7.5 6.25 5.5;
     -12 22 15.5 -1];

B = [12;
     -6.5;
     16;
     17];

solA = Gauss(A,B);
disp(solA);


function x = Gauss(a,b)

% The function solves a system of linear equations [a][x] = [b] using
% the Gauss elimination method.

% Input variables:
% a - The matrix of coefficients
% b - Right hand-side column vector of constants

% Output variable:
% x - A column vector with the solution

ab = [a,b];
[R, C] = size(ab);

for j = 1:R -1
    for i = j + 1:R

        pivotElement = ab(j,j);
        pivotEquation = ab(j,j:C);

        % Multiplier mij
        multiplier = ab(i,j)/pivotElement;


        ab(i,j:C) = ab(i,j:C) - multiplier * pivotEquation;
    end
end

x = zeros(R,1);
x(R) = ab(R,C)/ab(R,R);

for i = R -1:-1:1
    % Back substitution
    x(i) = (ab(i,C) - ab(i,i + 1:R) * x(i + 1:R)) / ab(i,i);
end

end
