function Marked_image = ugradnja_DWT(Image, skrembl_zig1)
% Generisanje slike oznacene koriscenjem Wavelet transformacije-----------
global Level K
% Level = 3
%-------------------------------------------------------------------------
[Image_DWT, bookie] = wavedec2(Image, Level, 'haar');
Marked_Image_DWT = Image_DWT;  % init
%-------------------------------------------------------------------------
horiz_detalji3 = wavecopy('h', Image_DWT, bookie, Level);
vert_detalji3 = wavecopy('v', Image_DWT, bookie, Level);
dijag_detalji3 = wavecopy('d', Image_DWT, bookie, Level);
zig_horiz_detalji3 = horiz_detalji3 + K/2/100 * abs(horiz_detalji3).*skrembl_zig1;
zig_vert_detalji3 = vert_detalji3 + K/2/100 * abs(vert_detalji3) .* skrembl_zig1;
zig_dijag_detalji3 = dijag_detalji3 + K/2/100 * abs(dijag_detalji3) .* skrembl_zig1;
%-------------------------------------------------------------------------
Marked_Image_DWT = wavepaste('h', Marked_Image_DWT, bookie, Level, zig_horiz_detalji3);
Marked_Image_DWT = wavepaste('v', Marked_Image_DWT, bookie, Level, zig_vert_detalji3);
Marked_Image_DWT = wavepaste('d', Marked_Image_DWT, bookie, Level, zig_dijag_detalji3);
%-------------------------------------------------------------------------
hor_detailes_2 = wavecopy('h', Image_DWT, bookie, Level-1);
ver_detailes_2 = wavecopy('v', Image_DWT, bookie, Level-1);
dijag_detalji2 = wavecopy('d', Image_DWT, bookie, Level-1);
skrembl_zig2 = repmat(skrembl_zig1, Level - 1);

mkd_hor_detailes_2 = hor_detailes_2 + 2*K/100 * abs(hor_detailes_2).*skrembl_zig2;
mkd_ver_detailes_2 = ver_detailes_2 + 2*K/100 * abs(ver_detailes_2) .* skrembl_zig2;
zig_dijag_detalji2 = dijag_detalji2 + 2*K/100 * abs(dijag_detalji2) .* skrembl_zig2;
%-------------------------------------------------------------------------
Marked_Image_DWT = wavepaste('h', Marked_Image_DWT, bookie, Level-1, mkd_hor_detailes_2);
Marked_Image_DWT = wavepaste('v', Marked_Image_DWT, bookie, Level-1, mkd_ver_detailes_2);
Marked_Image_DWT = wavepaste('d', Marked_Image_DWT, bookie, Level-1, zig_dijag_detalji2);
%-------------------------------------------------------------------------
Marked_image = waverec2(Marked_Image_DWT, bookie, 'haar');