% gaussian  Gaussian line shape 
%
%   y = gaussian(x,x0,fwhm)
%   y = gaussian(x,x0,fwhm,diff)
%
%   Returns a area-normalized Gaussian line shape
%   or one of its derivatives.
%
%   Input:
%   - x:    Abscissa vector
%   - x0:   Centre of the lineshape function
%   - fwhm: Full width at half height
%   - diff: Derivative. 0 is no derivative, 1 first,
%           2 second, -1 the integral with -infinity
%           as lower limit. 0 is the default.
%
%   Output:
%   - y:    Vector of function values for arguments x
