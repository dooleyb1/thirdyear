rng(123)
A = randi(10, 3, 3)
[L,U] = LUdecompGauss(A)
L*U

function [L, U] = LUdecompGauss(A)

rows = size(A, 1);
L = eye(n);                                                   

for k = 1 : n
    % For each row k, access columns from k+1 to the end and divide by
    % the diagonal coefficient at A(k ,k)
    L(k + 1 : n, k) = A(k + 1 : n, k) / A(k, k);

    % For each row k+1 to the end, perform Gaussian elimination
    % In the end, A will contain U
    for l = k + 1 : n
        A(l, :) = A(l, :) - L(l, k) * A(k, :);
    end
end
U = A;

end
