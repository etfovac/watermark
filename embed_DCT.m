function Marked_Image_DCT = embed_DCT(Image, scrambeled_wmark1, block_dim, K)
% Generate Marked_Image_DCT 
[Vs, Ss] = size(Image);
% Middle DCT coeffs range is selected for watermarking
y = 1; n = 1; v = 1; m = 1; d = 0; x = 0;
average = [  0, 0, y, n, v, m, d, x;    
             0, y, n, v, m, d, x, 0;
             y, n, v, m, d, x, 0, 0;
             n, v, m, d, x, 0, 0, 0;
             v, m, d, x, 0, 0, 0, 0;
             m, d, x, 0, 0, 0, 0, 0;
             d, x, 0, 0, 0, 0, 0, 0;
             x, 0, 0, 0, 0, 0, 0, 0  ];
Marked_Image_DCT = zeros(size(Image)); % init
T = dctmtx(block_dim);
z1 = 0; % init
for s1 = 1: block_dim: Vs
    z1 = z1 + 1;
    z2 = 0; % init
    for s2 = 1: block_dim: Ss
        z2 = z2 + 1;
        indx1 = s1: s1 + block_dim - 1;
        indx2 = s2: s2 + block_dim - 1;
        block = Image(indx1, indx2);
        DCT_block = T * block * T'; % output is double
        mrk = K/100 * scrambeled_wmark1(z1, z2); % scrambeled_wmark1(z1, z2) is 1 or -1
        Mrk_DCT_block = DCT_block + (abs(DCT_block)*mrk).*average;
        Marked_Image_DCT(indx1, indx2) = T' * Mrk_DCT_block * T; % output is double
    end
end
