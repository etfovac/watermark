function rek_zig = izdvajanje_DCT(slika, ozn_slika, b2)
% Rekonstrukcija ziga iz oznacene slike ----------------------------------
global dim_bloka vis_ziga sir_ziga Vs Ss
%-------------------------------------------------------------------------
y = 1; n = 1; v = 1; m = 1; d = 0; x = 0;
srednji = [  0, 0, y, n, v, m, d, x;    
             0, y, n, v, m, d, x, 0;
             y, n, v, m, d, x, 0, 0;
             n, v, m, d, x, 0, 0, 0;
             v, m, d, x, 0, 0, 0, 0;
             m, d, x, 0, 0, 0, 0, 0;
             d, x, 0, 0, 0, 0, 0, 0;
             x, 0, 0, 0, 0, 0, 0, 0  ];
skrembl_zig = zeros(vis_ziga,sir_ziga); % inicijalizacija
T = dctmtx(dim_bloka);
z1 = 0; % inicijalizacija
for s1 = 1: dim_bloka: Vs
    z1 = z1 + 1;
    z2 = 0; % inicijalizacija
    for s2 = 1: dim_bloka: Ss
        z2 = z2 + 1;
        indeks1 = s1: s1 + dim_bloka - 1;
        indeks2 = s2: s2 + dim_bloka - 1;
        blok = slika(indeks1, indeks2);
        ozn_blok = ozn_slika(indeks1, indeks2);
        DCT_blok = T * blok * T';   % izlaz f-je je double tipa
        DCT_ozn_blok = T * ozn_blok * T';   % izlaz f-je je double tipa
        B = (DCT_ozn_blok - DCT_blok) .* srednji;
        if sum(sum(B)) > 0
            skrembl_zig(z1, z2)= 1;
        else
            skrembl_zig(z1, z2)= 0;
        end
    end
end
rek_zig = skrembl_zig;  % inicijalizacija
rek_zig(b2) = skrembl_zig;