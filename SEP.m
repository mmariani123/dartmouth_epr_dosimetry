%This SEP routine is taken from Xiaoming He's PhD thesis.

function [sep] = SEP(x,y,a,b)

for i = 1:length(y)
    y(i) = y(i)-a;
end

y = y./b;

for j = 1 : length(x)
    z(j) = x(j) - y(j);
    z(j) = z(j)^2;
end

sumNow = sum(z);

sep = sqrt(sumNow/(length(z)-2));       

end