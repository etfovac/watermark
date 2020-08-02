function napad = napad_kompresijom(Zig_slika_uint8)
%-------------------------------------------------------------------------
% JPEG kompresija

kvalitet = [10 20 30 40 50 60 70 80 90 100];

for i = 1:length(kvalitet)
    ime = ['Kompr_Ozn_slika_', num2str(kvalitet(i)), '.jpeg'];
    imwrite(Zig_slika_uint8, ime, 'Quality', kvalitet(i));
end

napad = 'Izvrsen je napad JPEG kompresijom.';