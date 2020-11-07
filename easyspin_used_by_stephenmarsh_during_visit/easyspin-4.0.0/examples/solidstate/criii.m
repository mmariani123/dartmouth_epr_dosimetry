% Cr(III) at Q band
%==========================================================================
clear, clf, clc

% parameters and options for pepper
Par = struct('mwFreq',34,'Range',[900 1550],'nPoints',4096);
Opt = struct('nKnots',[46 1],'Verbosity',1);

% system without Cr nucleus
Sys = struct('S',3/2,'g',1.990,'D',[3000 750],'lw',1);
[B,spec1] = pepper(Sys,Par,Opt);

% system with 53Cr nucleus
Sys = nucspinadd(Sys,'53Cr',[1 2]*360);
[B,spec2] = pepper(Sys,Par,Opt);

% display
subplot(3,1,1); plot(B,spec1);
axis tight; title('without 53Cr nucleus');
subplot(3,1,2); plot(B,spec2);
axis tight; title('with 53Cr nucleus');
spec3 = spec1/sum(cumsum(spec1))*0.895+spec2/sum(cumsum(spec2))*0.095;
subplot(3,1,3); plot(B,spec3);
axis tight; title('natural isotope mixture');
xlabel('magnetic field [mT]');
