function napad = napad_filtriranjem(Zig_slika)
%-------------------------------------------------------------------------
% Filtriranje

w0 = fspecial('average');
w1 = fspecial('gaussian');
w2 = fspecial('unsharp');
w3 = fspecial('log');
w4 = fspecial('laplacian');

M0 = imfilter(Zig_slika, w0, 'corr');
M1 = imfilter(Zig_slika, w1, 'corr');
M2 = imfilter(Zig_slika, w2, 'corr');
M3 = imfilter(Zig_slika, w3, 'corr');
M4 = imfilter(Zig_slika, w4, 'corr');

M5 = medfilt2(Zig_slika);

imwrite(uint8(M0), 'Filt_Ozn_slika_aver.tif');
imwrite(uint8(M1), 'Filt_Ozn_slika_gaus.tif');
imwrite(uint8(M2), 'Filt_Ozn_slika_unsh.tif');
imwrite(uint8(Zig_slika - M3), 'Filt_Ozn_slika_log.tif');
imwrite(uint8(Zig_slika - M4), 'Filt_Ozn_slika_lapl.tif');
imwrite(uint8(M5), 'Filt_Ozn_slika_median.tif');

napad = 'Izvrsen je napad filtriranjem.';