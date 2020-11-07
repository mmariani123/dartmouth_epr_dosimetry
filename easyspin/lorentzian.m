% lorentzian  Lorentzian line shape 
%
%   ya = lorentzian(x,x0,fwhm)
%   ya = lorentzian(x,x0,fwhm,diff)
%   [ya,yd] = ...
%
%   Returns area-normalized Lorentzian absorption and
%   dispersion line shapes or their derivatives.
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
%   - ya:    absorption function values for abscissa x
%   - yd:    dispersion function values for abscissa x
