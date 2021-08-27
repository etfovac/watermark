function [Image, Vs, Ss] = adj_image(orig_Image, block_dim)
% Image dimensions adjustment (zero padding)
Vor = size(orig_Image, 1); % h
Sor = size(orig_Image, 2); % w
remainder1 = mod(Vor, block_dim);
remainder2 = mod(Sor, block_dim);
if (remainder1 ~= 0) || (remainder2 ~= 0)
    Image = padarray(orig_Image, [remainder1, remainder2], 0, 'post');
    % Image dimensions
    Vs = size(Image, 1);
    Ss = size(Image, 2);
    fprintf('\n Image dimensions are set to: %ix%i.', Vs, Ss);
else
    Image = orig_Image;
    % Image dimensions
    Vs = size(Image, 1);
    Ss = size(Image, 2);
end
