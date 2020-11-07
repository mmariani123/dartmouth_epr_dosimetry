% sham  Spin Hamiltonian 
%
%   [F,Gx,Gy,Gz] = sham(sys)
%   [F,G] = sham(sys, B)
%   H = sham(sys, B)
%
%   Constructs a spin Hamiltonian.
%
%   Input:
%   - 'sys': spin system specification structure
%   - 'B': 1x3 vector specifying the magnetic field [mT]
%
%   Output:
%   - 'H': complete spin Hamiltonian [MHz]
%   - 'F','G',Gx','Gy','Gz' ([MHz] and [MHz/mT])
%      H = F + B(1)*Gx + B(2)*Gy + B(3)*Gz = F + |B|*G
