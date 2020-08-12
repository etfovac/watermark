function [nc, y] = wavecut(type, c, s, n)
%WAVECUT Zeroes coefficients in a wavelet decomposition structure.
%   [NC, Y] =   WAVECUT(TYPE, C, S, N) returns a new decomposition
%   vector whose detail or approximation coefficients (based on TYPE
%   and N) have been zeroed. The coefficients that were zeroed are
%   returned in Y.
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
%   See also WAVEWORK, WAVECOPY, AND WAVEPASTE.
%
% Taken from: Rafael C. Gonzalez, Richard E. Woods. and Steven L. Eddins,
% Digital Image Processing Using MATLAB®, Prentice-Hall Inc, 2002.

narginchk(3, 4);
if nargin == 4
    [nc, y] = wavework('cut', type, c, s, n);
else
        [nc, y] = wavework('cut', type, c, s);
end