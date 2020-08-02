function Zig_slika = ugradnja_DCT(slika, skrembl_zig1)
% Generisanje slike oznacene koriscenjem DCT transformacije--------------- 
global dim_bloka K Vs Ss
% Srednji opseg DCT koeficijenata
% u koje ce se ugraditi DWM (digitalni vodeni zig)
y = 1; n = 1; v = 1; m = 1; d = 0; x = 0;
srednji = [  0, 0, y, n, v, m, d, x;    
             0, y, n, v, m, d, x, 0;
             y, n, v, m, d, x, 0, 0;
             n, v, m, d, x, 0, 0, 0;
             v, m, d, x, 0, 0, 0, 0;
             m, d, x, 0, 0, 0, 0, 0;
             d, x, 0, 0, 0, 0, 0, 0;
             x, 0, 0, 0, 0, 0, 0, 0  ];
Zig_slika = zeros(Vs,Ss); % inicijalizacija
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
        DCT_blok = T * blok * T'; % izlaz f-je je double tipa
        beleg = K/100 * skrembl_zig1(z1, z2); % skrembl_zig1(z1, z2) je 1 ili -1
        Zig_DCT_blok = DCT_blok + (abs(DCT_blok)*beleg).*srednji;
        Zig_slika(indeks1, indeks2) = T' * Zig_DCT_blok * T; % izlaz f-je je double tipa
    end
end
