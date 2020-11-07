function [slope dataOut slopeString sepString rSquaredString] = LineFit(doses,signal,xRange,fitType,intercept)

doses(any(isnan(doses),2),:)=[];
signal(any(isnan(signal),2),:)=[];

if strcmpi(fitType,'pf') %'polynomial fit'
[coefficients offset]=polyfit(doses,signal,1);
slope = coefficients(1);
dataOut = polyval(coefficients', xRange);
yIntercept = coefficients(2);
x1 = doses;
y1 = signal;
a1 = coefficients(2);
b1 = coefficients(1);
rSquared = 1 - offset.normr^2 / norm(signal-mean(signal))^2;
elseif strcmpi(fitType,'ls') %least squares'
%However, if you wish to constrain the fit to go through a specific point, for example (x0, y0) where:
x0 = 0;
y0 = 0;
doses = doses(:); %reshape the data into a column vector
signal = signal(:);
n = 1; 
V(:,n+1) = ones(length(doses),1,class(doses));
for j = n:-1:1
     V(:,j) = doses.*V(:,j+1);
end
C = V;
d = signal;
A = [];
b = [];
Aeq = x0.^(n:-1:0);
beq = 10;
[p,rSquared] = lsqlin(C,d,A,b, Aeq, beq);
slope = p(1);
dataOut = polyval(p,xRange);
x1 = doses;
y1 = signal;
a1 = 0;
b1 = p(1);
yIntercept = p(2);
else
    error('You must choose appropriate ''fitType''!');
end
yInterceptString = num2str(yIntercept);
sepReturn = SEP(x1,y1,a1,b1);
sepReturnString = num2str(sepReturn);
sepString = horzcat('SEP: ',sepReturnString,' ','Gy');
rSquaredString = num2str(rSquared);
rSquaredString = horzcat('R^2',':',' ',rSquaredString);
xString = num2str(slope);
bString = 0;
slopeString = horzcat('y = ',xString,'x',' ','+',' ',yInterceptString);
end