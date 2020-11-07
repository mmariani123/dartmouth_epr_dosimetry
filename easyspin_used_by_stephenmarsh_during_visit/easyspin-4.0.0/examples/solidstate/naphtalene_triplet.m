% Excited triplet state of naphthalene in a duren host
%==========================================================================
% see C.A.Hutchison et al, J.Chem.Phys. 34 (1961) 908-922
% and Weil/Bolton/Wertz, pages 161 and 162
% Here we simulate the X-band powder spectrum

clear, clf, clc

convert = 100*clight/1e6; % cm^-1 -> MHz conversion factor

Naphthalene.S = 1;
Naphthalene.g = 2.003;
Naphthalene.D = [0.1003 0.0137]*convert;
Naphthalene.lwpp = 6;

Xband.mwFreq = 9.5;
Xband.Range = [0 500];

pepper(Naphthalene,Xband);
