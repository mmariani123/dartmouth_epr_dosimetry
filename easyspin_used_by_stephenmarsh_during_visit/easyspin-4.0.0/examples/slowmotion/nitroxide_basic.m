% Simple slow-motional cw EPR spectrum simulation of a nitroxide radical
%==========================================================================
clear, clf

% Parameters
%--------------------------------------------------------------------------
% Static parameters
g = [2.008,2.006,2.003];
Nitroxide.g = g;
Nitroxide.Nucs = '14N';
Nitroxide.A = [20,20,85];

% Dynamic parameters
Nitroxide.lw = 0.3;
Nitroxide.tcorr = 5e-9;

% Experimental parameters
Experiment = struct('mwFreq',9.5);


% Simulation and graphical rendering
%--------------------------------------------------------------------------
chili(Nitroxide,Experiment);
