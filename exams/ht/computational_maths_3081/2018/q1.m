res = SquareRoot(3);
disp(res);

function Xs = SquareRoot(p)

  % Check if p is positive
  if p <= 0
    disp('Error: P must be positive');
    return;
  end

  % Initialise Xn to be p
  Xn = p;
  error = 0.00001;

  % Do iterations here
  for i=1:20

    fx = (Xn)^2 - p;
    fxPrime = 2*(Xn);

    % Xn+1 = Xn - f(Xn)/f'(Xn)
    Xn1 = Xn - (fx)/(fxPrime);
    fprintf('Iteration %d: Xn1 = %d\n\n',i,Xn1);

    % Check error value here, if less than specified, end
    if abs((Xn1 - Xn)/Xn) < error
      % If within bounds, solution found, return
      Xs = Xn1;
      fprintf('Soultion found on iteration %d: Xn1 = %d\n\n',i,Xn1);
      return;
    end;

    % Store Xn1 as Xn for next iteration
    Xn = Xn1;
  end

  % If we make it here, no solution in 20 iterations
  fprintf('No solution found');
  Xs = 'No solution';
end
