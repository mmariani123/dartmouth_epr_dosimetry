% excitation profile of a mw pulse
%==========================================================================
% In this example, we compute the excitation
% profile of a pi pulse of a given length and
% compare it to the sinc function, which we
% would expect, if spin dynamics was linear.

clear, clf

% parameters
%-------------------------------------------------------------
tp = 0.1; % pulse length [µs]
FlipAngle = pi; % angle

maxoffset = 4/tp; % offset range limit [MHz]
n = 1e3; % number of points

% computation
%-------------------------------------------------------------
M0 = [0;0;1]; % equilibrium magnetization
offsetFreq = maxoffset*linspace(-1,1,n);
offAngle = 2*pi*tp*offsetFreq;

% loop over all offsets and compute z magnetization
%-------------------------------------------------------------
Mz = zeros(1,n);
for k = 1:length(offsetFreq)
  M = expm([0 offAngle(k) 0; -offAngle(k) 0 -FlipAngle; 0 FlipAngle 0])*M0;
  Mz(k) = M(3);
end

sincMz = 1 - 2*abs(sin(offAngle/2)./(offAngle/2));

% plotting
%--------------------------------------------------------------------
h = plot(offsetFreq,Mz,'b',offsetFreq,sincMz,'r-');
set(h(1),'LineWidth',2);
xlabel('frequency offset [MHz]');
ylabel('z magnetization after pulse');
title(sprintf('pi pulse with length %f us',tp));
legend('Bloch solution','linear response (sinc)',4);
