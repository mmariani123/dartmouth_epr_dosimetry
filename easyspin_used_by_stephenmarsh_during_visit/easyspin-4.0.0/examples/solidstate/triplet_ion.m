% Simple high-spin S=1 simulation
%----------------------------------------------------------
clear, clf

% A simple S=1 spin system (e.g. Ni(II), a d^8 ion)
Sys.S = 1;
Sys.g = 2;  % isotropic g
Sys.lwpp = 4; % Gaussian FWHM, mT

% Zero-field splitting in terms of D and E
D = 1000;  % MHz
E = 0.1*D;
Sys.D = [D E];

Exp.mwFreq = 10;             % GHz
Exp.Range = [100 500]; % mT

pepper(Sys,Exp);
