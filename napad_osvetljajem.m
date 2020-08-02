function napad = napad_osvetljajem(Zig_slika)
global faktor
%-------------------------------------------------------------------------
% Modifikacija osvetljaja
b = [0.1 0.2 0.3 0.4 0.5];

for i = 1:length(b)
    osv_slika = Zig_slika + b(i);
    iznad1 = find(osv_slika > 1);
    osv_slika(iznad1) = ones(size(iznad1));
    imwrite(uint8(osv_slika * faktor),['Osv_Ozn_slika_',num2str(b(i)),'.tif']);
end

for i = 1:length(b)
    osv_slika = Zig_slika - b(i);
    ispod1 = find(osv_slika < 0);
    osv_slika(ispod1) = zeros(size(ispod1));
    imwrite(uint8(osv_slika * faktor),['Osv_Ozn_slika_-',num2str(b(i)),'.tif']);
end

napad = 'Izvrsen je napad modifikacijom osvetljaja.';