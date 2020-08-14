function rek_zig = extract_DWT(Image, Marked_image, b2, Level, factor, hdim_wmark, wdim_wmark)
% Reconstruct watermark from a marked image ---------------------------------
% Level = 3
%-------------------------------------------------------------------------
[Image_DWT, bookie] = wavedec2(Image, Level, 'haar');
horiz_detalji3 = wavecopy('h', Image_DWT, bookie, Level);
vert_detalji3 = wavecopy('v', Image_DWT, bookie, Level);
dijag_detalji3 = wavecopy('d', Image_DWT, bookie, Level);
horiz_detalji2 = wavecopy('h', Image_DWT, bookie, Level-1);
vert_detalji2 = wavecopy('v', Image_DWT, bookie, Level-1);
dijag_detalji2 = wavecopy('d', Image_DWT, bookie, Level-1);
%-------------------------------------------------------------------------
[Marked_Image_DWT, ozn_bookie] = wavedec2(Marked_image, Level, 'haar');
ozn_horiz_detalji3 = wavecopy('h', Marked_Image_DWT, ozn_bookie, Level);
ozn_vert_detalji3 = wavecopy('v', Marked_Image_DWT, ozn_bookie, Level);
ozn_dijag_detalji3 = wavecopy('d', Marked_Image_DWT, ozn_bookie, Level);
ozn_horiz_detalji2 = wavecopy('h', Marked_Image_DWT, ozn_bookie, Level-1);
ozn_vert_detalji2 = wavecopy('v', Marked_Image_DWT, ozn_bookie, Level-1);
ozn_dijag_detalji2 = wavecopy('d', Marked_Image_DWT, ozn_bookie, Level-1);
%-------------------------------------------------------------------------
skrembl_zig3 = ((ozn_horiz_detalji3 - horiz_detalji3) + ...
    (ozn_vert_detalji3 - vert_detalji3) + ...
    (ozn_dijag_detalji3 - dijag_detalji3));
skrembl_zig2 = ((ozn_horiz_detalji2 - horiz_detalji2) + ...
    (ozn_vert_detalji2 - vert_detalji2) + ...
    (ozn_dijag_detalji2 - dijag_detalji2));
skrembl_zig = skrembl_zig2(1:hdim_wmark, 1:wdim_wmark) + ...
    skrembl_zig2(hdim_wmark + 1:hdim_wmark * 2, 1:wdim_wmark) + ...
    skrembl_zig2(1:hdim_wmark, wdim_wmark + 1:wdim_wmark * 2) + ...
    skrembl_zig2(hdim_wmark + 1:hdim_wmark * 2, wdim_wmark + 1:wdim_wmark * 2)...
    + skrembl_zig3;
skrembl_zig = round(skrembl_zig * factor);
%-------------------------------------------------------------------------
rek_zig = skrembl_zig;  % init
rek_zig(b2)= skrembl_zig;
kec = rek_zig > 0;
nula = rek_zig < 0;
rek_zig(kec) = 1;
rek_zig(nula) = 0;
