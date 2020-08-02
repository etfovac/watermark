function rek_zig = izdvajanje_DWT(slika, ozn_slika, b2)
% Rekonstrukcija ziga iz oznacene slike ---------------------------------
global Nivo vis_ziga sir_ziga faktor
% Nivo = 3
%-------------------------------------------------------------------------
[DWT_slike, knjigovodja] = wavedec2(slika, Nivo, 'haar');
horiz_detalji3 = wavecopy('h', DWT_slike, knjigovodja, Nivo);
vert_detalji3 = wavecopy('v', DWT_slike, knjigovodja, Nivo);
dijag_detalji3 = wavecopy('d', DWT_slike, knjigovodja, Nivo);
horiz_detalji2 = wavecopy('h', DWT_slike, knjigovodja, Nivo-1);
vert_detalji2 = wavecopy('v', DWT_slike, knjigovodja, Nivo-1);
dijag_detalji2 = wavecopy('d', DWT_slike, knjigovodja, Nivo-1);
%-------------------------------------------------------------------------
[DWT_ozn_slike, ozn_knjigovodja] = wavedec2(ozn_slika, Nivo, 'haar');
ozn_horiz_detalji3 = wavecopy('h', DWT_ozn_slike, ozn_knjigovodja, Nivo);
ozn_vert_detalji3 = wavecopy('v', DWT_ozn_slike, ozn_knjigovodja, Nivo);
ozn_dijag_detalji3 = wavecopy('d', DWT_ozn_slike, ozn_knjigovodja, Nivo);
ozn_horiz_detalji2 = wavecopy('h', DWT_ozn_slike, ozn_knjigovodja, Nivo-1);
ozn_vert_detalji2 = wavecopy('v', DWT_ozn_slike, ozn_knjigovodja, Nivo-1);
ozn_dijag_detalji2 = wavecopy('d', DWT_ozn_slike, ozn_knjigovodja, Nivo-1);
%-------------------------------------------------------------------------
skrembl_zig3 = ((ozn_horiz_detalji3 - horiz_detalji3) + ...
    (ozn_vert_detalji3 - vert_detalji3) + ...
    (ozn_dijag_detalji3 - dijag_detalji3));
skrembl_zig2 = ((ozn_horiz_detalji2 - horiz_detalji2) + ...
    (ozn_vert_detalji2 - vert_detalji2) + ...
    (ozn_dijag_detalji2 - dijag_detalji2));
skrembl_zig = skrembl_zig2(1:vis_ziga, 1:sir_ziga) + ...
    skrembl_zig2(vis_ziga + 1:vis_ziga * 2, 1:sir_ziga) + ...
    skrembl_zig2(1:vis_ziga, sir_ziga + 1:sir_ziga * 2) + ...
    skrembl_zig2(vis_ziga + 1:vis_ziga * 2, sir_ziga + 1:sir_ziga * 2)...
    + skrembl_zig3;
skrembl_zig = round(skrembl_zig * faktor);
%-------------------------------------------------------------------------
rek_zig = skrembl_zig;  % inicijalizacija
rek_zig(b2)= skrembl_zig;
kec = find(rek_zig > 0);
nula = find(rek_zig < 0);
rek_zig(kec) = 1;
rek_zig(nula) = 0;
