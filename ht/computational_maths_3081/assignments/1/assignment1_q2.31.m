% Write a user-defined MATLAB function that calculates the determinant of a square (n x n) matrix,
% where n can be 2, 3, or 4.
%
% For function name and arguments, use D =Determinant (A).
% The input argument A is the matrix whose determinant is calculated.
% The function Determinant should first check if the matrix is square.
% If it is not, the output D should be the message "The matrix must be square."
%
%
% Use Determinant to calculate the determinant of the following two matrices:

a = [1 5 4;
     2 3 6;
     1 1 1];

b = [4 6;
     3 8];

c = [1 2 3 4;
     5 6 7 8;
     9 10 11 12;
     13 14 15 16];

d = [1 2 3;
     4 5 6];

disp(Determinant(c));


function D = Determinant(A)

  % Get number of rows and columns
  [rows,columns] = size(A);

  % Verify square matrix & n inRange 2:4
  if rows == columns && (rows >= 2 && rows <= 4)
      if rows == 2
          D = det2x2(A);
      elseif rows == 3
          D = det3x3(A);
      else
          D = det4x4(A);
      end
  else
      D = 'Matrix must be square with 2 =< n <= 4';
  end

end

% 2x2 determinants
function D = det2x2(A)

  D = (A(1,1)*A(2,2)) - (A(1,2)*A(2,1))

end

% 3x3 determinants
function D = det3x3(A)

  aPart = A(1,1)*det2x2(A([2 3], 2:3));
  bPart = A(2,1)*det2x2(A([1 3], 2:3));
  cPart = A(3,1)*det2x2(A([1 2], 2:3));

  D = aPart - bPart + cPart;

end

% 4x4 determinants
function D = det4x4(A)

  aPart = A(1,1)*det3x3(A([2 3 4], 2:4));
  bPart = A(2,1)*det3x3(A([1 3 4], 2:4));
  cPart = A(3,1)*det3x3(A([1 2 4], 2:4));
  dPart = A(4,1)*det3x3(A([1 2 3], 2:4));

  D = aPart - bPart + cPart - dPart;

end
