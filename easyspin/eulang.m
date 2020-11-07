% eulang  Euler angles from rotation matrix 
%
%   Angles = eulang(Rp)
%   [alpha,beta,gamma] = eulang(Rp)
%
%   Returns the three Euler angles [alpha, beta, gamma]
%   (in radians) of the rotation matrix Rp. The rotation
%   matrix must be a 3x3 real matrix with determinant 1.
%   For a definition of the angles, see erot().
%   Since [alpha,beta,gamma] and [alpha+-pi,-beta,
%   gamma+-pi] give the same rotation matrix, eulang()
%   returns the set with beta>=0.
