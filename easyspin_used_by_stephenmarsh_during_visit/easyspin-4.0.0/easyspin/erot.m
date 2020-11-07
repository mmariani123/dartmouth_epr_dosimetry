% erot  Rotation matrix from Euler angles
%
%   Rp = erot(Angles)
%   Rp = erot(alpha,beta,gamma)
%
%   Computes a 3x3 rotation matrix Rp from
%   a vector of 3 Euler angles.
%
%   Input
%   - Angles: vector containing the three
%     Euler angles (in radians) that define
%     the rotation. [alpha, beta, gamma] rotate
%     the coordinate system around [z,y',z'']
%     counterclockwise in in that order.
%   - alpha, beta, gamma: the three Euler angles
%     as defined above.
%
%   Output
%   - Rp: matrix for the passive rotation
%       vec1 = Rp*vec or
%       mat1 = Rp*mat*Rp.'
