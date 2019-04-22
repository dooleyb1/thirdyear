function I1 = Simpsons38(fun, a, b)

  % Fun = Declaration of function
  % a,b = Input variables

  g = 10 * (b-a);
  x = zero;
  y = zeros;
  I1 = zeros;

  w = log(g)/log(2);
  max = 1;

  for i=1:2000
    if i<w
      max=max+1;
    end
  end

end
