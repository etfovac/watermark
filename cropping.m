function attack = cropping(image_uint8, folder)
global Vs Ss
%-------------------------------------------------------------------------
% Cropping (removing parts of the image, and replacing it with zeroes)

s = [1.6 2 4 8 16 32 64];
for i = 1:length(s)
    cut1 = Vs/s(i);
    cut2 = Ss;
    image_uint8(1:cut1, 1:cut2) = zeros(cut1, cut2);
    path = strcat(folder, ['Vcrop_Mkd_img_',num2str(s(i)),'.tif']);
    imwrite(image_uint8, path);
end

for i = 1:length(s)
    cut1 = Vs/s(i);
    cut2 = Ss/s(i);
    image_uint8(1:cut1, 1:cut2) = zeros(cut1, cut2);
    path = strcat(folder, ['VScrop_Mkd_img_',num2str(s(i)),'.tif']);
    imwrite(image_uint8, path);
end

attack = 'An attack by cropping.';