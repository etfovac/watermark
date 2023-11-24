function attack = noise(Marked_image,folder)
%-------------------------------------------------------------------------
% add noise
I1 = imnoise(Marked_image, 'Gaussian',0,0.002);
I2 = imnoise(Marked_image, 'salt & pepper',0.015);
I3 = imnoise(Marked_image, 'speckle',0.01);

imwrite(uint8(I1), strcat(folder, '\', 'Noise_Mkd_img_gaus.tif'));
imwrite(uint8(I2), strcat(folder, '\', 'Noise_Mkd_img_salt.tif'));
imwrite(uint8(I3), strcat(folder, '\', 'Noise_Mkd_img_speck.tif'));

attack = 'An attack by addin noise.';