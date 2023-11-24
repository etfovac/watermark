function attack = brightness(Marked_image, folder, factor)
%-------------------------------------------------------------------------
% Modify brightness
b = [0.1 0.2 0.3 0.4 0.5];

for i = 1:length(b)
    osv_slika = Marked_image + b(i);
    iznad1 = find(osv_slika > 1);
    osv_slika(iznad1) = ones(size(iznad1));
    path = strcat(folder, '\', ['Bright_Mkd_img_',num2str(b(i)),'.tif']);
    imwrite(uint8(osv_slika * factor),path);
end

for i = 1:length(b)
    osv_slika = Marked_image - b(i);
    ispod1 = find(osv_slika < 0);
    osv_slika(ispod1) = zeros(size(ispod1));
    path = strcat(folder, '\', ['Bright_Mkd_img_-',num2str(b(i)),'.tif']);
    imwrite(uint8(osv_slika * factor), path);
end

attack = 'An attack by brightness change.';