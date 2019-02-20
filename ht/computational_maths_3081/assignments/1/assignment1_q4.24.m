% Write a user-defined MATLAB function that determines the inverse of a matrix
% using the Gauss-Jordan method. For the function name and arguments use
%
% Ainv =Inverse (A), where A is the matrix to be inverted, and Ainv is the inverse of the matrix.

% Use the Inverse function to calculate the inverse of:

a = [-1 2 1;
      2 2 -4;
      0.2 1 0.5];

b = [-1 -2 1 2;
      1 1 -4 -2;
      1 -2 -4 -2;
      2 -4 1 -2];

disp(Inverse(a));
disp('----------------------------------------');
disp(Inverse(b));

function Ainv = Inverse(A)

  % Get number of rows and columns
  [rows,columns] = size(A);

  % Verify square matrix
  if rows ~= columns
    disp('Error: Matrix is not square');
    Ainv = [];
    return
  end

  % Generate the identity matrix
  Ainv = eye(rows);


  for j = 1 : rows
    for i = j : rows

        % If A(i,j) is 0 ignore
        if A(i,j) ~= 0

            % For every row swap A(j,k) and A(i,k), do the same with Ainv
            for k = 1 : rows
                s = A(j,k); A(j,k) = A(i,k); A(i,k) = s;
                s = Ainv(j,k); Ainv(j,k) = Ainv(i,k); Ainv(i,k) = s;
            end

            % Calculate a divisor to set diagonal A(j,j) to 1
            t = 1/A(j,j);

            for k = 1 : rows
                % For every A(j,k) multiply by divisor, do the same with Ainv
                A(j,k) = t * A(j,k);
                Ainv(j,k) = t * Ainv(j,k);
            end

            for L = 1 : rows
                % For every non-diagonal row
                if L ~= j

                    % Calculate number needed to eliminate A(L,j)
                    t = -A(L,j);

                    for k = 1 : rows
                        % Perform elimination using t to set non-diagonal elements to zero
                        A(L,k) = A(L,k) + t * A(j,k);
                        Ainv(L,k) = Ainv(L,k) + t * Ainv(j,k);
                    end
                end
            end
        end
        break
    end

    % Display warning if a row full of zeros is found
    if A(i,j) == 0
        disp('Warning: Singular Matrix')
        Ainv = 'error';
        return
    end
  end
end
