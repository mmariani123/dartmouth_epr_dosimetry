% rescale     Rescaling of one spectrum so that it fits a second
%
%   ynew = rescale(y,mode1)
%   ynew = rescale(y,yref,mode2)
%
%   Shifts and rescales the spectrum y. If given, ynew serves
%   as the reference. The rescaled y is returned in ynew.
%
%   mode1:
%     'minmax'  shifts&scales to minimum 0 and maximum 1
%     'maxabs'  scales to maximum abs 1, no shift
%
%   mode2:
%     'minmax'  shifts&scales so that minimum and maximum fit yref
%     'maxabs'  scales so that maximum abs fits yref
%     'lsq'     least-squares fit of a*y
%     'lsq0'    least-squares fit of a*y+b
%     'lsq1'    least-squares fit of a*y+b+c*x
%     'lsq2'    least-squares fit of a*y+b+c*x+d*x^2
