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
%     Sys.tcorr           rotational correlation time (in seconds)
%     Sys.logtcorr        log10 of rotational correlation time (in seconds)
%     Sys.Diff            diffusion rate (s^-1)
%     Sys.logDiff         log10 of diffusion rate (s^-1)
%
%         All fields can have 1 (isotropic), 2 (axial) or 3 (rhombic) elements.
%         Precedence: logtcorr > tcorr > logDiff > Diff.
%
%     Sys.Diffpa          Euler angles of the diffusion tensor (default [0 0 0])
%     Sys.lw              vector with FWHM residual broadenings [mT]
%                         1 element:  GaussianFWHM
%                         2 elements: [GaussianFWHM LorentzianFWHM]
%     Sys.lwpp            peak-to-peak line widths [mT], same format as Sys.lw
%     Sys.lambda          ordering potential coefficients
%                         [lambda20 lambda22 lambda40 lambda42 lambda44]
%     Sys.Exchange        Heisenberg exchange frequency (in MHz)
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
%     Exp.MOMD            0: single orientation, 1: MOMD model
%     Exp.psi             "director tilt" orientation
%
%     Opt.LLKM            basis size: [evenLmax oddLmax Kmax Mmax]
%     Opt.Verbosity       0: no display, 1: show info
%     Opt.nKnots          number of knots for powder simulation (MOMD)
%
%   Output:
%     B      magnetic field axis vector, in mT
%     spc    simulated spectrum, arbitrary units
%
%     If no output arguments are specified, chili plots the
%     simulated spectrum.
