% zfield  Electronic zero field interaction Hamiltonian 
%
%   F = zfield(SpinSystem)
%   F = zfield(SpinSystem,Electrons)
%
%   Returns the electronic zero-field interaction (ZFI)
%   Hamiltonian [MHz] of the system SpinSystem.
%
%   If the vector Electrons is given, the ZFI of only the
%   specified electrons is returned (1 is the first, 2 the
%   second, etc). Otherwise, all electrons are included.
