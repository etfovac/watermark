function [slika, Vs, Ss] = podes_slike(orig_slika)
global dim_bloka
% Podesavanje dimenzija slike (dopuna nulama ako treba)
% Dimenzije originalne slike
Vor = size(orig_slika, 1); % visina
Sor = size(orig_slika, 2); % sirina
ostatak1 = mod(Vor, dim_bloka);
ostatak2 = mod(Sor, dim_bloka);
if (ostatak1 ~= 0) || (ostatak2 ~= 0)
    slika = padarray(orig_slika, [ostatak1, ostatak2], 0, 'post');
    % Dimenzije slike
    Vs = size(slika, 1);
    Ss = size(slika, 2);
    fprintf('\n Dimenzije slike su podesene na: %ix%i.', Vs, Ss);
else
    slika = orig_slika;
    % Dimenzije slike
    Vs = size(slika, 1);
    Ss = size(slika, 2);
end
