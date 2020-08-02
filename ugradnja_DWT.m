function Zig_slika = ugradnja_DWT(slika, skrembl_zig1)
% Generisanje slike oznacene koriscenjem Wavelet transformacije-----------
global Nivo K
% Nivo = 3
%-------------------------------------------------------------------------
[DWT_slike, knjigovodja] = wavedec2(slika, Nivo, 'haar');
Zig_DWT_slike = DWT_slike;  % inicijalizacija
%-------------------------------------------------------------------------
horiz_detalji3 = wavecopy('h', DWT_slike, knjigovodja, Nivo);
vert_detalji3 = wavecopy('v', DWT_slike, knjigovodja, Nivo);
dijag_detalji3 = wavecopy('d', DWT_slike, knjigovodja, Nivo);
zig_horiz_detalji3 = horiz_detalji3 + K/2/100 * abs(horiz_detalji3).*skrembl_zig1;
zig_vert_detalji3 = vert_detalji3 + K/2/100 * abs(vert_detalji3) .* skrembl_zig1;
zig_dijag_detalji3 = dijag_detalji3 + K/2/100 * abs(dijag_detalji3) .* skrembl_zig1;
%-------------------------------------------------------------------------
Zig_DWT_slike = wavepaste('h', Zig_DWT_slike, knjigovodja, Nivo, zig_horiz_detalji3);
Zig_DWT_slike = wavepaste('v', Zig_DWT_slike, knjigovodja, Nivo, zig_vert_detalji3);
Zig_DWT_slike = wavepaste('d', Zig_DWT_slike, knjigovodja, Nivo, zig_dijag_detalji3);
%-------------------------------------------------------------------------
horiz_detalji2 = wavecopy('h', DWT_slike, knjigovodja, Nivo-1);
vert_detalji2 = wavecopy('v', DWT_slike, knjigovodja, Nivo-1);
dijag_detalji2 = wavecopy('d', DWT_slike, knjigovodja, Nivo-1);
skrembl_zig2 = repmat(skrembl_zig1, Nivo - 1);
% skrembl_zig2 = [skrembl_zig1, skrembl_zig1; skrembl_zig1, skrembl_zig1];
zig_horiz_detalji2 = horiz_detalji2 + 2*K/100 * abs(horiz_detalji2).*skrembl_zig2;
zig_vert_detalji2 = vert_detalji2 + 2*K/100 * abs(vert_detalji2) .* skrembl_zig2;
zig_dijag_detalji2 = dijag_detalji2 + 2*K/100 * abs(dijag_detalji2) .* skrembl_zig2;
%-------------------------------------------------------------------------
Zig_DWT_slike = wavepaste('h', Zig_DWT_slike, knjigovodja, Nivo-1, zig_horiz_detalji2);
Zig_DWT_slike = wavepaste('v', Zig_DWT_slike, knjigovodja, Nivo-1, zig_vert_detalji2);
Zig_DWT_slike = wavepaste('d', Zig_DWT_slike, knjigovodja, Nivo-1, zig_dijag_detalji2);
%-------------------------------------------------------------------------
Zig_slika = waverec2(Zig_DWT_slike, knjigovodja, 'haar');