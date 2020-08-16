function rec_wmark= extract_DCT(Image, Marked_image, b2, block_dim, hdim_wmark, wdim_wmark)
% Reconstruct wmark
[Vs, Ss] = size(Image);
%-------------------------------------------------------------------------
y = 1; n = 1; v = 1; m = 1; d = 0; x = 0;
range = [  0, 0, y, n, v, m, d, x;    
             0, y, n, v, m, d, x, 0;
             y, n, v, m, d, x, 0, 0;
             n, v, m, d, x, 0, 0, 0;
             v, m, d, x, 0, 0, 0, 0;
             m, d, x, 0, 0, 0, 0, 0;
             d, x, 0, 0, 0, 0, 0, 0;
             x, 0, 0, 0, 0, 0, 0, 0  ];
skrembl_zig = zeros(hdim_wmark,wdim_wmark); % init
T = dctmtx(block_dim);
z1 = 0; % init
for s1 = 1: block_dim: Vs
    z1 = z1 + 1;
    z2 = 0; % init
    for s2 = 1: block_dim: Ss
        z2 = z2 + 1;
        indeks1 = s1: s1 + block_dim - 1;
        indeks2 = s2: s2 + block_dim - 1;
        block = Image(indeks1, indeks2);
        mkd_block = Marked_image(indeks1, indeks2);
        DCT_blok = T * block * T';   % double
        DCT_ozn_blok = T * mkd_block * T';   % double
        B = (DCT_ozn_blok - DCT_blok) .* range;
        if sum(sum(B)) > 0
            skrembl_zig(z1, z2)= 1;
        else
            skrembl_zig(z1, z2)= 0;
        end
    end
end
rec_wmark = skrembl_zig;  % init
rec_wmark(b2) = skrembl_zig;