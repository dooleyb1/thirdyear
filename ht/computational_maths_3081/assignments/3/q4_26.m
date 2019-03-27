A = [-2, 1, 0;
      1, -2, 1;
      0, 1, -1.5];

B = [4, -1, 0, 1, 0;
     -1, 4, -1, 0, 1;
     0, -1, 4, -1, 0;
     1, 0, -1, 4, -1;
     0, 1, 0, -1, 4];


ansA = InfinityNorm(A);
ansB = InfinityNorm(B);

output = sprintf('AnsA = %d\nAnsB = %d',ansA,ansB);
disp(output);

%Write the MATLAB code to find the infinity norm of a matrix A
function N = InfinityNorm(A)

A = abs(A);

[m,n] = size(A);

for k=1:m
  sum(k)=0;
end

%Iterate over matrix
for i=1:m
  for j=1:n
    sum(i) = sum(i) + A(i,j);
  end
end

N = max(sum);

end
