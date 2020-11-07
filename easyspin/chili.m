% chili    Simulation of cw EPR spectra in the slow motional regime
%
%   chili(Sys,Exp,Opt)
%   spc = chili(...)
%   [B,spc] = chili(...)
%
%   Computes the slow-motion cw EPR spectrum of systems with
%   one electron and one nuclear spin.
%
%   Input:
%     Sys                 spin system structure
%
%     Sys.tcorr           isotropic correlation time (in seconds)
%     Sys.logtcorr        log10 of isotropic correlation time (in seconds)
%     Sys.Diff            1- or 2-element vector with diffusion rates (s^-1)
%     Sys.logDiff         log10 of diffusion rates (s^-1)
%
%         If logtcorr/logDiff is given, tcorr/Diff is ignored.
%
%     Sys.Diffpa          Euler angles of the diffusion tensor (default [0 0 0])
%     Sys.lw              vector with FWHM residual broadenings [mT]
%                         1 element:  GaussianFWHM
%                         2 elements: [GaussianFWHM LorentzianFWHM]
%     Sys.lwpp            peak-to-peak line widths [mT], same format as Sys.lw
%     Sys.Exchange        Heisenberg exchange frequency (in Hz)
%
%     Exp.mwFreq          spectrometer frequency, in GHz
%     Exp.CenterSweep     [centerField sweepWidth], in mT
%     Exp.Range           [minField maxField], in mT
%
%          Exp.Range is only used if Exp.CenterSweep is not given.
%          If both Exp.CenterField and Exp.Range are omitted, the
%          magnetic field range is determined automatically.
%
%     Exp.nPoints         number of points (default 1024)
%     Exp.Harmonic        detection harmonic: 0, 1, 2 (default 1)
%
%     Opt.LLKM            basis size: [evenLmax oddLmax Kmax Mmax]
%     Opt.Verbosity       0: no display, 1: show info
%
%   Output:
%     B      magnetic field axis vector, in mT
%     spc    simulated spectrum, arbitrary units
%
%     If no output arguments are specified, chili plots the
%     simulated spectrum.
