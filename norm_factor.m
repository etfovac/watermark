function factor = norm_factor(I)
% Input images are: uint8 (0-255) or uint16 (0-65535) or double (0-1).

if isa(I, 'uint8')
    factor = 255;
elseif isa(I, 'uint16')
    factor = 65535;
else
    factor = 1;
end