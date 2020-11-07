% pepper  Computation of powder cw EPR spectra 
%
%   pepper(Sys,Exp)
%   pepper(Sys,Exp,Opt)
%   spec = pepper(...)
%   [B,spec] = pepper(...)
%   [B,spec,Trans] = pepper(...)
%
%   Calculates a field-swept cw EPR spectrum.
%
%   Input:
%   - Sys: parameters of the paramagnetic system
%       S, g, Nucs, A, Q, D, ee,
%       gpa, Apa, Qpa, Dpa, eepa
%       lw, lwpp
%       HStrain, gStrain, AStrain, DStrain
%       B20 etc.
%   - Exp: experimental parameters
%       mwFreq        spectrometer frequency, in GHz
%       CenterSweep   magnetic field range [center,sweep], in mT
%       Range         magnetic field range [low,high], in mT
%       nPoints       number of points
%       Temperature   temperature of the sample, by default off
%       Harmonic      detection harmonic: 0, 1 (default), 2
%       Detection     detection mode: 'parallel', 'perpendicular' (default)
%       Orientations  orientations for single-crystal simulations
%       Ordering      coefficient for non-isotropic orientational distribution
%   - Opt: computational options
%       Method        'perturb1','perturb2'='perturb','matrix'
%       Verbosity, Output,
%       Symmetry, SymmFrame,
%       nKnots, Intensity
%       Transitions, nTransitions, Threshold
%
%   Output:
%   - B:      the field axis, in mT
%   - spec:   the spectrum
%   - Trans:  transitions included in the calculation
%
%   If no output argument is given, the simulated spectrum is plotted.
