%fit_levmar  Levenberg-Marquardt nonlinear least squares
%
%   xfit = levmar(funfcn,x0)
%   [xfit,Info] = levmar(funfcn,x0)
%   ... = levmar(funfcn,x0,Opt)
%   ... = levmar(funfcn,x0,Opt,p1,p2,...)
%
%   Find  xm = argmin{F(x)} , where  x = [x_1, ..., x_n]  and
%   F(x) = 0.5 * sum(f_i(x)^2). The functions  f_i(x) (i=1,...,m)
%   must be given by a Matlab function with declaration
%              function  f = funfcn(x, p1,p2,...)
%   p1,p2,... are parameters of the function.  In connection with 
%   nonlinear data fitting they may be arrays with coordinates of 
%   the data points.
%
% Input
%   funfcn  :  Handle to the function.
%   x0   :  Starting guess for xm.
%   Opt  :  options
%         Opt.lambda  starting value of Marquardt parameter
%         Opt.Gradient  termination threshold for gradient
%         Opt.TolStep   termination threshold for step
%         Opt.maxTime   termination threshold for time
%         Opt.delta     step width for Jacobian approximation
%           delta  "relative" step length for difference approximations.
%   p1,p2,..  are passed directly to the function FUN .    
%
% Output
%   xfit :  Computed solution vector.
%   Info :  Performance information, vector with 7 elements:
%           info(1:4) = final values of 
%               [F(x)  ||F'||inf  ||dx||2  mu/max(A(i,i))] ,
%             where  A = Je'* Je .
%           info(5) = no. of iteration steps
%           info(6) = 1 :  Stopped by small gradient
%                     2 :  Stopped by small x-step
%                     3 :  No. of iteration steps exceeded 
%                    -4 :  Dimension mismatch in x, f, B0
%                    -5 :  Overflow during computation
%                    -6 :  Error in approximate Jacobian
%           info(7) = no. of function evaluations
