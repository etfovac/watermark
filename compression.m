function attack = compression(Marked_image_uint8, folder)
%-------------------------------------------------------------------------
% JPEG

quality = [10 20 30 40 50 60 70 80 90 100];

for i = 1:length(quality)
    path = strcat(folder, ['JPEG_Mkd_img_', num2str(quality(i)), '.jpeg']);
    imwrite(Marked_image_uint8, path, 'Quality', quality(i));
end

attack = 'An attack by JPEG compression.';