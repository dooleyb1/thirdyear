function N = OneNorm(A)

  % Find the row and column dimensions
  [row, cols] = size(A);

  % Iterate over columns
  for j=1:cols
    % Calculate sum of columns and store in array
    column_sums(j) = sum(abs(A(:,j)));
  end;

  % Initialise max
  max = column_sums(1);

  % Find the largest value amongst the sums
  for j=1:cols-1
    if column_sums(j+1) > max
      max = column_sums(j+1);
    end
  end

  % Return max
  N = max;

end
