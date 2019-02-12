%            P(F|E) * P(E)
% P(E|F) = ----------------
%                P(F)
%
%
% P(F) = P(F|E)P(E) + P(F|!E)P(!E)

% Prior belief P(E)
priorBelief = [0.05 0.10 0.05 0.05;
               0.05 0.10 0.05 0.05;
               0.05 0.05 0.10 0.05;
               0.05 0.05 0.10 0.05];

% P(F|E)
pBarsGivenLocation = [0.75 0.95 0.75 0.05;
                      0.05 0.75 0.95 0.75;
                      0.01 0.05 0.75 0.95;
                      0.01 0.01 0.05 0.75];

% P(E|F)
pLocationGivenBars = zeros(4, 4);

% Calculate P(F) using marginalisation
%
pF = 0;

for i = 1:4
    for j = 1:4
      % P(F) = P(F ∩ E1) + P(F ∩ E2) + . . .
      pF = pF+(priorBelief(i,j)*pBarsGivenLocation(i,j));

    end
end

for i = 1:4
    for j = 1:4

        % Calculate P(F|E), P(E)
        pFE = pBarsGivenLocation(i,j);
        pE = priorBelief(i,j);

        % Apply Bayes rule for P(E|F)
        pEF = (pFE.*pE)./pF;
        % Store result in pLocationGivenBars
        pLocationGivenBars(i,j) = pEF;
    end
end

disp(pLocationGivenBars);
disp(sum(pLocationGivenBars, 'all'));
