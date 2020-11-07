% nucspinadd  Adds a nuclear spin to a spin system
%
%    NewSys = nucspinadd(Sys,Nuc,A)
%    NewSys = nucspinadd(Sys,Nuc,A,Apa)
%    NewSys = nucspinadd(Sys,Nuc,A,Apa,Q)
%    NewSys = nucspinadd(Sys,Nuc,A,Apa,Q,Qpa)
%
%    Add the nuclear isotope Nuc (e.g. '14N') to
%    the spin system structure, with the hyperfine
%    values A, the hyperfine tilt angles Apa, the
%    quadrupole values Q and the quadrupole tilt angles
%    Qpa. Any missing parameter is assumed to be [0 0 0].
%
%    Example:
%     Sys = struct('S',1/2,'g',[2 2 2.2]);
%     Sys = nucspinadd(Sys,'63Cu',[50 50 520]);
