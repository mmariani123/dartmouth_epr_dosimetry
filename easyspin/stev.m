% stev  Extended Stevens spin operators 
%
%   Op = stev(S,k,q)
%
%   Constructs extended Stevens operators for
%   0<=k<=2*S and -k<=q<=k for the spin S. If S
%   is a vector representing the spins of a spin
%   system, Op is computed for the first spin in
%   the state space of the full spin system.
%   The maximum k supported is 12, the most common
%   values for k are 2, 4 and 6.
%
%   Input:
%   - S: spin quantum number
%   - k,q: indices specifying O_k^q
%
%   Output:
%   - Op: extended Stevens operator matrix
%
%   Example:
%    To obtain O_4^2 for a spin 5/2, type
%
%       stev(5/2,4,2)
