% zeeman  Zeeman interaction Hamiltonian 
%
%   [Zx, Zy, Zz] = zeeman(SpinSystem)
%   [Zx, Zy, Zz] = zeeman(SpinSystem, Spins)
%
%   Returns the Zeeman interaction Hamiltonian for
%   the spins 'Spins' of the spin system 'SpinSystem'.
%
%   Input:
%   - SpinSystem: Spin system structure.
%   - Spins: Vector of spin numbers. For one electron spin: 1
%     is the electron, >=2 are the nuclei. For two electron
%     spins: 1 and 2 electrons, >=3 nuclei, etc. If Spins is
%     omitted, all spins are included.
%
%   Output:
%   - Zx, Zy, Zz: components of the Zeeman interaction
%     for the selected spins as defined by Zi=d(H)/d(B_i)
%     i=x,y,z where B_i are the cartesian components of
%     the external field. Units are MHz/mT = 1e9 Hz/T.
