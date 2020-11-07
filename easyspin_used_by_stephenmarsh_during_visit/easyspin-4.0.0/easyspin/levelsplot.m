% levelsplot    plot energy level diagram 
%
%  levelsplot(Sys,Ori,B);
%  levelsplot(Sys,Ori,B,mwFreq);
%
%    Sys        spin system structure
%    Ori        2-element vector [phi theta]
%               Euler angles for the magnetic field
%               alternatively, either 'x', 'y' or 'z'
%    B          field range [Bmin Bmax] in mT
%    mwFreq     spectrometer frequency in GHz
%
%  If mwFreq is given, resonances are drawn. Red
%  lines indicate allowed transitions, gray lines
%  forbidden ones. If the lines are terminated with
%  dots, the relative transition intensity is larger
%  than 1%.
%
%  Example:
%    Sys = struct('S',7/2,'g',[2 2 2],'D',[1 1 -2]*5e3);
%    levelsplot(Sys,[0;pi/3],[0 6e3],95);
