function nc = wavepaste(type, c, s, n, x)
%WAVEPASTE Puts coefficients of a wavelet decomposition structure.
%   NC =   WAVEPASTE(TYPE, C, S, N) returns a new decomposition  
%   structure after pasting X into it based on TYPE and N.
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
%       X is a two-dimensional approximation or detail coefficient
%         matrix whose dimensions are appropriate for decomosition
%         level N.
%
%   See also WAVEWORK, WAVECUT, AND WAVECOPY.
%
% UZETO IZ: Rafael C. Gonzalez, Richard E. Woods. and Steven L. Eddins,
% Digital Image Processing Using MATLAB®, Prentice-Hall Inc, 2002.

error(nargchk(5, 5, nargin));
nc = wavework('paste', type, c, s, n, x);
