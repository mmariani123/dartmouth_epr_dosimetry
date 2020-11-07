function [lineSign] = line_sign(arg)

%returns string lineSign = '+' if arg >= 0.
%returns string lineSign = '-' otherwise.

if sign(arg)==1 || sign(arg)==0 
    lineSign = '+';
else
    lineSign = '-';
end

end
