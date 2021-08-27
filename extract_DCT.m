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
scrambeled_wmark = zeros(hdim_wmark,wdim_wmark); % init
T = dctmtx(block_dim);
z1 = 0; % init
for s1 = 1: block_dim: Vs
    z1 = z1 + 1;
    z2 = 0; % init
    for s2 = 1: block_dim: Ss
        z2 = z2 + 1;
        idx1 = s1: s1 + block_dim - 1;
        idx2 = s2: s2 + block_dim - 1;
        block = Image(idx1, idx2);
        mkd_block = Marked_image(idx1, idx2);
        DCT_block = T * block * T';   % double
        DCT_mrk_block = T * mkd_block * T';   % double
        B = (DCT_mrk_block - DCT_block) .* range;
        if sum(sum(B)) > 0
            scrambeled_wmark(z1, z2)= 1;
        else
            scrambeled_wmark(z1, z2)= 0;
        end
    end
end
rec_wmark = scrambeled_wmark;  % init
rec_wmark(b2) = scrambeled_wmark;