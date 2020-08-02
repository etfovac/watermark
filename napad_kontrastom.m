function napad = napad_kontrastom(Zig_slika)
global faktor
%-------------------------------------------------------------------------
% Modifikacija kontrasta
c = [0.5 0.6 0.7 0.9 1.1 1.4 1.5 1.6 1.7 1.8];

for i = 1:length(c)
    kon_slika1 = c(i)* Zig_slika;
    imwrite(uint8(kon_slika1 * faktor),['Mkon_Ozn_slika_',...
        num2str(c(i)),'.tif']);
end

bin = [8 16 32 64 96 128 160 192 224 240];

for i = 1:length(bin)
    h_kon_slika = histeq(Zig_slika, bin(i));
    imwrite(uint8(h_kon_slika * faktor),['Hkon_Ozn_slika_',...
        num2str(bin(i)),'.tif']);
end

napad = 'Izvrsen je napad modifikacijom kontrasta.';