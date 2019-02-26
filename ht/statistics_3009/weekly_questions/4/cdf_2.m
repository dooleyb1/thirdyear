x = [1, 2, 3, 4, 5, 6];
y = [0, 0, 0, 0, 0, 0];

lastResult=0;
for i=1:5
 px=(i/6)^4;
 newResult= px + lastResult;
 lastResult = newResult;
 y(i) = newResult;
end

y(6) = (6/6)^4;

bar(x,y)

title('Cumulative Probability for P(X=x)');
xlabel('x')
ylabel('CDF(x)')
