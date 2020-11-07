% cw EPR as a multiphoton experiment
%==========================================================================
% This example illustrates the fact that the simple cw EPR
% absorption line in reality is the result of overlap of many
% sidebands.
% See Kaelin et al, J.Magn.Reson. 160, 166-182 (2003)

% first harmonic absorption spectrum, in-phase modulation

clear, clf

Harmonic = 1;   % harmonic (0, 1, 2, etc)
ModInPhase = 1; % 1 modulation in-phase, 0 out-of-phase
Absorption = 1; % 1 absorption, 0 dispersion mode
FreqAxis = 1;

fmod = 10; % modulation frequency, in MHz
wrf = 2*pi*fmod; % Frequency of the modulation field [2*pi*MHz]
if FreqAxis
  Amod = 0.1;  % peak-to-peak modulation amplitude, in MHz
  lwpp = 10; % peak-to-peak line width, in MHz
  w2 = 2*pi*Amod/2; % Amplitude of the modulation field [2*pi*MHz]
  T2 = 1/lwpp; % Relaxation time [us]
else
  Amod = 0.01;  % peak-to-peak modulation amplitude, in mT
  lwpp = 0.1; % peak-to-peak line width, in mT
  w2 = 2*pi*mt2mhz(Amod/2); % Amplitude of the modulation field [2*pi*MHz]
  T2 = 1/mt2mhz(lwpp); % Relaxation time [us]
end


N = 100000;

beta = w2/wrf;
kmax = max(1.1*beta,beta+30);
kmax = ceil(kmax);

if FreqAxis
  freqmax = max(Amod*3,lwpp*8);
  freq = freqmax*linspace(-1,1,N);
  w = 2*pi*freq;
else
  fieldmax = max(Amod*3,lwpp*8);
  field = fieldmax*linspace(-1,1,N);
  w = 2*pi*mt2mhz(field);
end

spec = 0;
j = Harmonic;

Ap = ModInPhase;
D = (ModInPhase & ~Absorption) | (~ModInPhase & Absorption);
for k = -kmax:kmax
  if Ap
    Amplitude = besselj(-k+j,beta) + besselj(-k-j,beta);
  else
    Amplitude = besselj(-k+j,beta) - besselj(-k-j,beta);
  end
  Amplitude = Amplitude*besselj(-k,beta);
  if D
    Shape = (w-k*wrf).*T2^2./(1+(w-k*wrf).^2*T2^2);
  else
    Shape = T2./(1+(w-k*wrf).^2*T2^2);
  end
  spec = spec + Amplitude*Shape;
end
if ~(Absorption & ModInPhase)
  spec = -spec;
end

if FreqAxis
  plot(freq,spec);
  xlabel('offset frequency [MHz]');
else
  plot(field,spec);
  xlabel('offset field [mT]');
end
ylabel('amplitude [a.u.]');
