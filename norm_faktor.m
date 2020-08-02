function faktor = norm_faktor(I)
% Ulazne intenzitetne slike mogu biti klase: uint8 (nivoi 0-255)
% ili uint16 (nivoi 0-65535) ili double (u opsegu 0-1).

if isa(I, 'uint8')
    faktor = 255;
elseif isa(I, 'uint16')
    faktor = 65535;
else
    faktor = 1;
end