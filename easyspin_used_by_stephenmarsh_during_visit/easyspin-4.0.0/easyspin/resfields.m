% resfields  Compute resonance fields for cw EPR 
%
%   Pos = resfields(Sys,Par)
%   Pos = resfields(Sys,Par,Opt)
%   [Pos,Int] = resfields(...)
%   [Pos,Int,Wid] = resfields(...)
%   [Pos,Int,Wid,Trans] = resfields(...)
%
%   Computes cw EPR line positions, intensities and widths.
%
%   Input:
%   - Sys:    spin system structure
%   - Par:    experimental parameter settings
%             mwFreq:   in GHz
%             Range:    [Bmin Bmax] in mT
%             Temperature: in K, default inf
%             Mode: 'perpendicular','parallel'
%             Orientations:  orientations of the spin system in the spectrometer
%                   2xn or 3xn array containing [phi;theta{;chi}] in
%                   radians
%   - Opt:    additonal computational options
%             Transitions, Threshold, etc
%
%   Output:
%   - Pos:    line positions
%   - Int:    line intensities, possibly including gradients
%   - Wid:    line widths
%   - Trans:  list of transitions included in the computation
