%fit_simplex    Nelder/Mead downhill simplex minimization algorithm
%
%   xmin = fit_simplex(fcn,x0,Opt,varargin)
%   [xmin,info] = ...
%
%   Tries to minimize fcn(x), starting at x0. Opt are options for
%   the minimization algorithm, any additional parameters are passed
%   to the function to be minimized, fcn, which can be a string or
%   a function handle.
%
%   Options:
%     Opt.SimplexPars    [rho cho psi sigma], default [1 2 0.5 0.5]
%     Opt.maxTime        maximum time allowed, in minutes
%     Opt.delta              initial extension of simplex
