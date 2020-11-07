% eeint  Electron-electron interaction Hamiltonian 
%
%   F = eeint(SpinSystem)
%   F = eeint(SpinSystem,eSpins)
%
%   Returns the electron-electron interaction (EEI)
%   Hamiltonian [MHz].
%
%   Input:
%   - SpinSystem: Spin system structure. EEI
%       parameters are in the ee and eepa fields.
%   - eSpins: If given, specifies electron spins
%       for which the EEI should be computed. If
%       absent, all electrons are taken.
%
%   Output:
%   - F: Hamiltonian matrix containing the EEI for
%       electrons specified in eSpins.
