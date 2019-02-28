x = [1, 2, 3, 4, 5, 6];
y = [0, 0, 0, 0, 0, 0];

diff = 6;

for i=1:6
 y(diff) = 1-((6-diff)/6)^4;
 diff = diff - 1;
end

bar(x,y)

title('Cumulative Probability for P(X=x)');
xlabel('x')
ylabel('CDF(x)')
