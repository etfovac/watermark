function attack = brightness(Marked_image, folder, factor)
%-------------------------------------------------------------------------
% Modify brightness
b = [0.1 0.2 0.3 0.4 0.5];

for i = 1:length(b)
    bright_img = Marked_image + b(i);
    above_1 = find(bright_img > 1);
    bright_img(above_1) = ones(size(above_1));
    path = strcat(folder, '\', ['Bright_Mkd_img_',num2str(b(i)),'.tif']);
    imwrite(uint8(bright_img * factor),path);
end

for i = 1:length(b)
    bright_img = Marked_image - b(i);
    below_1 = find(bright_img < 0);
    bright_img(below_1) = zeros(size(below_1));
    path = strcat(folder, '\', ['Bright_Mkd_img_-',num2str(b(i)),'.tif']);
    imwrite(uint8(bright_img * factor), path);
end

attack = 'An attack by brightness change.';