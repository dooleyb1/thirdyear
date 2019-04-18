function [yd,ydd] = FirstSecondDeriv(x,y)

  n = length(x);

  % All points equally spaced
  h = (x(2)-x(1));

  % Use the three point forward difference formula for 1st and 2nd derivative
  yd(1) = (-3*y(1) + 4*y(2) - y(3)) / 2*h;
  ydd(1) = (y(1) - 2*y(2) + y(3)) / h^2;

  % Loop over the rest of the vectors
  for i=2:n-1
    % Use two point central difference formula for 1st derivative
    yd(i) = (y(i+1) - y(i-1)) / 2*h;

    % Use the three point central difference formula for 2nd derivative
    ydd(i) = (y(i-1) - 2*y(i) + y(i+1)) / h^2;
  end

  % For last entry use three point backward difference formula for 1st deriv
  yd(n) = (y(n-2) - 4*y(n-1) + 3*y(n)) / 2*h;

  % For last entry use three point backward difference formula for 2nd deriv
  ydd(n) = (y(n-2) - 2*y(n-1) + y(n)) / h^2;
end
