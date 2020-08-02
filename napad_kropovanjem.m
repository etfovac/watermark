function napad = napad_kropovanjem(Zig_slika_uint8)
global Vs Ss
%-------------------------------------------------------------------------
% Kropovanje (isecanje delova slike), iseceni deo se menja nulama

s = [1.6 2 4 8 16 32 64];
for i = 1:length(s)
    isecak1 = Vs/s(i);
    isecak2 = Ss;
    tmp_slika_uint8 = Zig_slika_uint8;
    tmp_slika_uint8(1:isecak1, 1:isecak2) = zeros(isecak1, isecak2);
    imwrite(tmp_slika_uint8, ['Vkrop_Ozn_slika_',num2str(s(i)),'.tif']);
end

for i = 1:length(s)
    isecak1 = Vs/s(i);
    isecak2 = Ss/s(i);
    tmp_slika_uint8 = Zig_slika_uint8;
    tmp_slika_uint8(1:isecak1, 1:isecak2) = zeros(isecak1, isecak2);
    imwrite(tmp_slika_uint8, ['VSkrop_Ozn_slika_',num2str(s(i)),'.tif']);
end

napad = 'Izvrsen je napad kropovanjem.';