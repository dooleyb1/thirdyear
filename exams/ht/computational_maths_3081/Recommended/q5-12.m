function e = AllEig(A)

  % Get nxn value
  [row, col] = size(A);

  for i=1:40
    % Generate identity matrix
    I = eye(row);
    Q = I;


    for j=1:row-1
      c = A(:,j);
      c(1:j-1) = 0;

      e(1:n,1) = 0;
    end
  end
end
