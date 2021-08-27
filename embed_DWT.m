function Marked_image = embed_DWT(Image, scrambled_mrk1, Level, K)
% Generate Marked_Image_DWT
% Level = 3
%-------------------------------------------------------------------------
[Image_DWT, bookie] = wavedec2(Image, Level, 'haar');
Marked_Image_DWT = Image_DWT;  % init
%-------------------------------------------------------------------------
horiz_detailes3 = wavecopy('h', Image_DWT, bookie, Level);
vert_detailes3 = wavecopy('v', Image_DWT, bookie, Level);
diagonal_detailes3 = wavecopy('d', Image_DWT, bookie, Level);
mrk_horiz_detailes3 = horiz_detailes3 + K/2/100 * abs(horiz_detailes3).*scrambled_mrk1;
mrk_vert_detailes3 = vert_detailes3 + K/2/100 * abs(vert_detailes3) .* scrambled_mrk1;
mrk_diagonal_detailes3 = diagonal_detailes3 + K/2/100 * abs(diagonal_detailes3) .* scrambled_mrk1;
%-------------------------------------------------------------------------
Marked_Image_DWT = wavepaste('h', Marked_Image_DWT, bookie, Level, mrk_horiz_detailes3);
Marked_Image_DWT = wavepaste('v', Marked_Image_DWT, bookie, Level, mrk_vert_detailes3);
Marked_Image_DWT = wavepaste('d', Marked_Image_DWT, bookie, Level, mrk_diagonal_detailes3);
%-------------------------------------------------------------------------
hor_detailes_2 = wavecopy('h', Image_DWT, bookie, Level-1);
ver_detailes_2 = wavecopy('v', Image_DWT, bookie, Level-1);
diagonal_detailes2 = wavecopy('d', Image_DWT, bookie, Level-1);
scrambled_mrk2 = repmat(scrambled_mrk1, Level - 1);

mkd_hor_detailes_2 = hor_detailes_2 + 2*K/100 * abs(hor_detailes_2).*scrambled_mrk2;
mkd_ver_detailes_2 = ver_detailes_2 + 2*K/100 * abs(ver_detailes_2) .* scrambled_mrk2;
mrk_diagonal_detailes2 = diagonal_detailes2 + 2*K/100 * abs(diagonal_detailes2) .* scrambled_mrk2;
%-------------------------------------------------------------------------
Marked_Image_DWT = wavepaste('h', Marked_Image_DWT, bookie, Level-1, mkd_hor_detailes_2);
Marked_Image_DWT = wavepaste('v', Marked_Image_DWT, bookie, Level-1, mkd_ver_detailes_2);
Marked_Image_DWT = wavepaste('d', Marked_Image_DWT, bookie, Level-1, mrk_diagonal_detailes2);
%-------------------------------------------------------------------------
Marked_image = waverec2(Marked_Image_DWT, bookie, 'haar');