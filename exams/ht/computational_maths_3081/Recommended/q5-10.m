function e = MaxEig(A)

  % Get rows and columns
  [row, col] = size(A);

  % Initial vector [1, 1, 1]
  x = [1; 1; 1];

  % Perform 8 iterations
  for j=1:8
    % Multiply matrix by x
    p = A * x;

    % Get the maximum element
    [maxVal, index] = max(abs(p(:)))
    maxVal = maxVal * sign(p(index))

    % Divide each element in vector by max multiplicative factor
    for i=1:cols
      x(i) = p(i)/maxVal;
    end
  end

  e = a;
end
