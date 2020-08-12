function attack = filtering(Marked_image,folder)
%-------------------------------------------------------------------------
% Filtering

w0 = fspecial('average');
w1 = fspecial('gaussian');
w2 = fspecial('unsharp');
w3 = fspecial('log');
w4 = fspecial('laplacian');

M0 = imfilter(Marked_image, w0, 'corr');
M1 = imfilter(Marked_image, w1, 'corr');
M2 = imfilter(Marked_image, w2, 'corr');
M3 = imfilter(Marked_image, w3, 'corr');
M4 = imfilter(Marked_image, w4, 'corr');

M5 = medfilt2(Marked_image);

imwrite(uint8(M0), strcat(folder, 'Filt_Mkd_img_aver.tif'));
imwrite(uint8(M1), strcat(folder, 'Filt_Mkd_img_gaus.tif'));
imwrite(uint8(M2), strcat(folder, 'Filt_Mkd_img_unsh.tif'));
imwrite(uint8(Marked_image - M3), strcat(folder, 'Filt_Mkd_img_log.tif'));
imwrite(uint8(Marked_image - M4), strcat(folder, 'Filt_Mkd_img_lapl.tif'));
imwrite(uint8(M5), strcat(folder, 'Filt_Mkd_img_median.tif'));

attack = 'An attack by filtering.';