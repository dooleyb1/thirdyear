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
      if rows == 1
          D = (A(1,1));
      else
          % Initialise determinant to 0 and create temp matrix
          D = 0;
          tempMatrix = A;

          for i = 1:columns
            % Store tempMatrix(1,i)
            tempRowElement = tempMatrix(1,i);

            if tempRowElement ~= 0
              % Remove row one
              tempMatrix(1,:)=[];
              % Remove the ith column
              tempMatrix(:,i)=[];
              % Recursively call determinant
              D = D + ((-1)^(1+i)) * tempRowElement * Determinant(tempMatrix);
              tempMatrix = A;
            end
          end
      end
  else
      D = 'Matrix must be square with 2 =< n <= 4';
  end

end
