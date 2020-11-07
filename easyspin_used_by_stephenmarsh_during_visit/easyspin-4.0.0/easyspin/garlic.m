% garlic    Simulates isotropic and fast-motion cw EPR spectra 
%
%   garlic(Sys,Exp)
%   spec = garlic(Sys,Exp)
%   [B,spec] = garlic(Sys,Exp)
%
%   Computes the solution cw EPR spectrum of systems with
%   an unpaired electron and arbitrary numbers of nuclear spins.
%
%   Input:
%     Sys.g            isotropic g factor or 3 principal values of g
%     Sys.Nucs         string with comma-separated list of isotopes
%     Sys.n            vector of number of equivalent nuclei (default all 1)
%     Sys.A            vector of hyperfine couplings [MHz]
%     Sys.lw           vector with FWHM line widths [mT]
%                       1 element:  GaussianFWHM
%                       2 elements: [GaussianFWHM LorentzianFWHM]
%     Sys.lwpp         peak-to-peak line widths [mT], same format as Sys.lw
%
%     Sys.tcorr        correlation time for fast-motion linewidths [s]
%                      If omitted or zero, the isotropic spectrum is computed.
%     Sys.logtcorr     log10 of the correlation time for fast-motion linewidths [s]
%                      If logtcorr is given, tcorr is ignored.
%
%     Exp.mwFreq       spectrometer frequency [GHz]
%     Exp.CenterSweep  [centerField sweepRange] in mT
%     Exp.Range        [minField maxField] in mT
%          Exp.Range is only used if Exp.CenterSweep is not given.
%          If both Exp.CenterField and Exp.Range are omitted, the
%          magnetic field range is determined automatically.
%
%     Exp.Harmonic     detection harmonic (0, 1, or 2), default 1
%     Exp.nPoints      number of points (default 1024)
%
%   Output
%     B                magnetic field axis [mT]
%     spec             spectrum [arbitrary units]
%
%     If no output parameter is specified, the simulated spectrum
%     is plotted.
%
%   Example isotropic spectrum
%
%     Sys = struct('g',2,'Nucs','1H,14N','A',[30,40],'n',[3,4]);
%     Sys.lwpp = [0,0.1];
%     Exp = struct('mwFreq',9.7,'nPoints',10000);
%     garlic(Sys,Exp);
%
%   Example fast-motion spectrum
%
%     A = [16, 16, 86];
%     Sys = struct('g',[2.0088 2.0061 2.0027],'Nucs','14N','A',A);
%     Sys.tcorr = 1e-9;
%     Exp = struct('mwFreq',9.5);
%     garlic(Sys,Exp);
