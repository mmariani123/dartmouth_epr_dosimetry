% Mixture of two copper-EDTA complexes
%----------------------------------------
% Cu-EDTA at pH 7 gives an EPR spectrum with two
% components. It can be simulated with a single
% call to pepper.

clear

% Component 1
Cu1.g = [2.04 2.321];
Cu1.A = [15 136]*2.8;
Cu1.Nucs = 'Cu';
Cu1.lwpp = 2;

% Component 2
Cu2.g = [2.032 2.288];
Cu2.A = [15 144]*2.8;
Cu2.Nucs = 'Cu';
Cu2.lwpp = 2;

% Relative abundances
Cu1.weight = 1;
Cu2.weight = 0.6;

% Experimental parameters
Xp.mwFreq = 9.5;
Xp.Range = [250 360];

% One call to pepper with both Cu1 and Cu2 gives
% directly the two-component spectrum.
pepper({Cu1,Cu2},Xp);
