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

% https://uk.mathworks.com/matlabcentral/answers/172984-help-with-nxn-matrices

a = [1 2 3;
     4 5 6;
     7 8 10];

% Get number of rows and columns
[rows,columns] = size(a);

if rows == columns && (rows >= 2 && rows <= 4)

end

function D = Determinant(A)

  % Get number of rows and columns
  [rows,columns] = size(a);

  % Verify square matrix & n inRange 2:4
  if rows == columns && (rows >= 2 && rows <= 4)

    % Switch based on rows
    if rows == 2
      D = det2x2(A);
    elseif rows == 3
      D = det3x3(A);
    else if rows == 4
      D = det4x4(A);
    end

  else
    D = 'Matrix must be square.';
  end

end
