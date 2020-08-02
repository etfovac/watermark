function napad = napad_sumom(Zig_slika)
%-------------------------------------------------------------------------
% Dodavanje suma

I1 = imnoise(Zig_slika, 'Gaussian',0,0.002);
I2 = imnoise(Zig_slika, 'salt & pepper',0.015);
I3 = imnoise(Zig_slika, 'speckle',0.01);

imwrite(uint8(I1), 'Sum_Ozn_slika_gaus.tif');
imwrite(uint8(I2), 'Sum_Ozn_slika_salt.tif');
imwrite(uint8(I3), 'Sum_Ozn_slika_speck.tif');

napad = 'Izvrsen je napad sumom.';