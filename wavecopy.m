function y = wavecopy(type, c, s, n)
%WAVECOPY Fetches coefficients of a wavelet decomposition structure.
%   Y =   WAVECOPY(TYPE, C, S, N) returns a coefficient array based on 
%   TYPE and N.
%
%   INPUTS:
%       TYPE        Coefficient category
%       -----------------------------------------------------------------
%       'a'         Approximation coefficients
%       'h'         Horizontal details
%       'v'         Vertical details
%       'd'         Diagonal details
%
%       [C, S] is a wavelet data structure.
%       N specifies a decomposition level (ignored if TYPE = 'a').
%
%   See also WAVEWORK, WAVECUT, AND WAVEPASTE.
%
% UZETO IZ: Rafael C. Gonzalez, Richard E. Woods. and Steven L. Eddins,
% Digital Image Processing Using MATLAB®, Prentice-Hall Inc, 2002.

error(nargchk(3, 4, nargin));
if nargin == 4
    y = wavework('copy', type, c, s, n);
else
    y = wavework('copy', type, c, s);
end