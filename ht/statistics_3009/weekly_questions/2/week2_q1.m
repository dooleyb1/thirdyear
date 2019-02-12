% Write a small matlab simulation of this experiment and confirm that the observed
% probability that at least one 2 is rolled matches your calculation in (a).

% 6 sided die with 3 rolls
dice_sides = 6;
num_rolls = 3;

% Events - At least one two is rolled
E = 0;

% Sample space = 6 ^ 3
S = dice_sides.^num_rolls;

for roll1 = 1:6
    for roll2 = 1:6
        for roll3 = 1:6

            % Check all occurances for a 2 being rolled and update counter
            if roll1 == 2
                E = E + 1;
            elseif roll2 == 2
                E = E + 1;
            elseif roll3 == 2
                E = E + 1;
            end
        end
    end
end


% P(E) = |E| / |S|
probability = E./S;
disp(probability);
