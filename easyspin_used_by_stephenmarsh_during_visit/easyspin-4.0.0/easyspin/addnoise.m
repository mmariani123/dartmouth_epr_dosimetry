% addnoise   Add noise to a signal
%
%   yn = addnoise(y,SNR,'u')
%   yn = addnoise(y,SNR,'n')
%
%   Adds noise to y to give yn with signal-to-noise ratio SNR.
%   'u': uniform distribution between -0.5/SNR and 0.5/SNR
%   'n': normal distribution with standard deviation 1/SNR
%
%   Example:
%     x = linspace(-1,1,1001);
%     y = gaussian(x,0,0.3);
%     yn = addnoise(y,10);
%     plot(x,yn);
