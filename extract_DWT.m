function returned_wmark = extract_DWT(Image, Marked_image, b2, Level, factor, hdim_wmark, wdim_wmark)
% Reconstruct watermark from a marked image ---------------------------------
% Level = 3
%-------------------------------------------------------------------------
[Image_DWT, bookie] = wavedec2(Image, Level, 'haar');
horiz_detailes3 = wavecopy('h', Image_DWT, bookie, Level);
vert_detailes3 = wavecopy('v', Image_DWT, bookie, Level);
diagonal_detailes3 = wavecopy('d', Image_DWT, bookie, Level);
horiz_detailes2 = wavecopy('h', Image_DWT, bookie, Level-1);
vert_detailes2 = wavecopy('v', Image_DWT, bookie, Level-1);
diagonal_detailes2 = wavecopy('d', Image_DWT, bookie, Level-1);
%-------------------------------------------------------------------------
[Marked_Image_DWT, mrk_bookie] = wavedec2(Marked_image, Level, 'haar');
mrk_horiz_detailes3 = wavecopy('h', Marked_Image_DWT, mrk_bookie, Level);
mrk_vert_detailes3 = wavecopy('v', Marked_Image_DWT, mrk_bookie, Level);
mrk_diagonal_detailes3 = wavecopy('d', Marked_Image_DWT, mrk_bookie, Level);
mrk_horiz_detailes2 = wavecopy('h', Marked_Image_DWT, mrk_bookie, Level-1);
mrk_vert_detailes2 = wavecopy('v', Marked_Image_DWT, mrk_bookie, Level-1);
mrk_diagonal_detailes2 = wavecopy('d', Marked_Image_DWT, mrk_bookie, Level-1);
%-------------------------------------------------------------------------
scrambeled_wmark3 = ((mrk_horiz_detailes3 - horiz_detailes3) + ...
    (mrk_vert_detailes3 - vert_detailes3) + ...
    (mrk_diagonal_detailes3 - diagonal_detailes3));
scrambeled_wmark2 = ((mrk_horiz_detailes2 - horiz_detailes2) + ...
    (mrk_vert_detailes2 - vert_detailes2) + ...
    (mrk_diagonal_detailes2 - diagonal_detailes2));
scrambeled_wmark = scrambeled_wmark2(1:hdim_wmark, 1:wdim_wmark) + ...
    scrambeled_wmark2(hdim_wmark + 1:hdim_wmark * 2, 1:wdim_wmark) + ...
    scrambeled_wmark2(1:hdim_wmark, wdim_wmark + 1:wdim_wmark * 2) + ...
    scrambeled_wmark2(hdim_wmark + 1:hdim_wmark * 2, wdim_wmark + 1:wdim_wmark * 2)...
    + scrambeled_wmark3;
scrambeled_wmark = round(scrambeled_wmark * factor);
%-------------------------------------------------------------------------
returned_wmark = scrambeled_wmark;  % init
returned_wmark(b2)= scrambeled_wmark;
One = returned_wmark > 0;
Zero = returned_wmark < 0;
returned_wmark(One) = 1;
returned_wmark(Zero) = 0;
