% salt  ENDOR spectra simulation 
%
%   salt(Sys,Exp)
%   salt(Sys,Exp,Opt)
%   spec = salt(...)
%   [rf,spec] = salt(...)
%   [rf,spec,Trans] = salt(...)
%
%   Input:
%   - Sys: spin system structure specification
%       S, g, Nucs, A, Apa, Q, Qpa etc.
%       lwEndor     FWHM Endor line width [Gaussian,Lorentzian]
%   - Exp: experiment specification
%       mwFreq        spectrometer frequency, in GHz
%       Field         magnetic field, in mT
%       Range         radiofrequency range [low,high], in MHz
%       nPoints       number of points
%       Temperature   temperature of the sample, by default off
%       ExciteWidth   ENDOR excitation width, FWHM, in MHz
%       Orientations  orientations for single-crystal simulations
%       Ordering      coefficient for non-isotropic orientational distribution
%   - Opt: simulation options
%       Transitions, Threshold, Symmetry
%       nKnots, Intensity, Enhancement, Output
%       ThetaRange
%
%   Output:
%   - rf:     the radiofrequency axis, in MHz
%   - spec:   the spectrum or spectra
%   - Trans:  level number pairs of the transitions in spec
%   If no output argument is given, the simulated spectrum is plotted.
