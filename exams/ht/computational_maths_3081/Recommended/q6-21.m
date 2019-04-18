function [b,m] = PowerFit(x,y);

  a = length(x);
  b = length(y);

  if a~=b
    error('SIZE OF x AND y MUST BE THE SAME');
  end

  sumx = 0;
  sumy = 0;
  sumxy = 0;
  sumx_2 = 0;

  % Calculate sum of log(x)'s and log(ys)
  for i=1:a
    sumx = sumx + log(x(i));
    sumy = sumy + log(y(i));

    sumx_2 = sumx_2 + ((log(x(i)))^2);
    sumxy = sumxy + (log(x(i)) * log(y(i)));
  end

  m = ((b*sumxy)-(sumx*sumy)) / ((b*sumx_2)-((sumx)^2));
  b = ((sumx_2*sumy)-(sumxy*sumx)) / ((b*sumx_2)-((sumx)^2));
  b = exp(b);
end
