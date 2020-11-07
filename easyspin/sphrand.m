% sphrand  Generate random points over unit sphere 
%
%   vecs = sphrand(N)
%   vecs = sphrand(N,k)
%   [phi,theta] = sphrand(...)
%
%   Generates N randomly distributed point over k
%   octants of the unit sphere. The underlying
%   distribution is uniform.
%
%   Input
%   - N: number of points
%   - k: number of octants, can be 1, 2, 4 or 8.
%        1 is the default.
%
%    Output
%   - vecs: 3xN array with column vectors
%   - phi, theta: polar angles in radians
