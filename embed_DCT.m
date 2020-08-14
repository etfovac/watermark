function Marked_Image_DCT = embed_DCT(Image, skrembl_zig1, dim_bloka, K)
% Generate Marked_Image_DCT 
global Vs Ss
% Middle DCT coeffs range is selected for watermarking
y = 1; n = 1; v = 1; m = 1; d = 0; x = 0;
srednji = [  0, 0, y, n, v, m, d, x;    
             0, y, n, v, m, d, x, 0;
             y, n, v, m, d, x, 0, 0;
             n, v, m, d, x, 0, 0, 0;
             v, m, d, x, 0, 0, 0, 0;
             m, d, x, 0, 0, 0, 0, 0;
             d, x, 0, 0, 0, 0, 0, 0;
             x, 0, 0, 0, 0, 0, 0, 0  ];
Marked_Image_DCT = zeros(size(Image)); % init
T = dctmtx(dim_bloka);
z1 = 0; % init
for s1 = 1: dim_bloka: Vs
    z1 = z1 + 1;
    z2 = 0; % init
    for s2 = 1: dim_bloka: Ss
        z2 = z2 + 1;
        indx1 = s1: s1 + dim_bloka - 1;
        indx2 = s2: s2 + dim_bloka - 1;
        block = Image(indx1, indx2);
        DCT_block = T * block * T'; % output is double type
        beleg = K/100 * skrembl_zig1(z1, z2); % skrembl_zig1(z1, z2) is 1 or -1
        Zig_DCT_blok = DCT_block + (abs(DCT_block)*beleg).*srednji;
        Marked_Image_DCT(indx1, indx2) = T' * Zig_DCT_blok * T; % output is double type
    end
end
