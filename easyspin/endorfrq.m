% endorfrq  Compute ENDOR frequencies and intensities 
%
%    Pos = endorfrq(Sys,Par)
%    Pos = endorfrq(Sys,Par,Opt)
%    [Pos,Int] = endorfrq(...)
%    [Pos,Int,Tra] = endorfrq(...)
%
%    Sys:  spin system structure
%
%    Par: parameter structure
%      mwFreq: spectrometer frequency [GHz]
%      Field:  magnetic field [mT]
%      Temperature: in K (optional, default inf)
%      ExciteWidth: FWHM of excitation [MHz] (optional, default inf)
%      Range: frequency range [MHz] (optional, default [])
%      Ori: 2xn or 3xn array of Euler angles
%        [phi;theta] or [phi;theta;chi]. If chi
%        is omitted, intensity is integrated over chi.
%
%    Opt: computational options structure
%      Verbosity: log level (0, 1 or 2)
%      Transitions: [mx2 array] of level pairs
%      Threshold: for transition selection.
%      Nuclei:   index for nuclei (1 to #nuclei)
%      Intensity: 'on','off'
%      Enhancement: 'on','off'
%
%    See the manual for a detailed description of the arguments.
