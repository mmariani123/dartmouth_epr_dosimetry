% fieldmod  field modulation 
%
%   yMod = fieldmod(x,y,ModAmpl);
%   yMod = fieldmod(x,y,ModAmpl,Harmonic);
%   fieldmod(...)
%
%   Computes the effect of field modulation
%   on an EPR absorption spectrum.
%
%   Input:
%   - x: magnetic field axis vector [mT]
%   - y: absorption spectrum
%   - ModAmpl: peak-to-peak modulation amplitude [mT]
%   - Harmonic: harmonic, greater than 0, default is 1
%
%   Output;
%   - yMod: pseudo-modulated spectrum
%
%   If no output variable is give, fieldmod plots the
%   original and the modulated spectrum.
%
%   Example:
%
%     x = linspace(300,400,1001);
%     y = lorentzian(x,342,4);
%     fieldmod(x,y,20);
