% voigtian  Voigtian line shape function 
%
%    y = voigtian(x,x0,fwhm);
%    y = voigtian(x,x0,fwhm,deriv);
%
%    Computes the convolution of a Gaussian and a
%    Lorentzian line shape function.
%
%    x     abscissa vector
%    x0    line shape centre
%    fwhm  [fwhm_Gauss fwhm_Lorentz]
%    deriv 0 (absorption), 1 (first), 2 (second
%          derivative)
%
%    y     Voigtian line shape, normalized to
%          integral 1
