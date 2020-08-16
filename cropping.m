function attack = cropping(Image, folder)
[Vs, Ss] = size(Image);
%-------------------------------------------------------------------------
% Cropping (removing parts of the image, and replacing it with zeroes)

s = [1.1 1.2 1.4 1.6 1.8 2 4 8 16];

for i = 1:length(s)
    strip = Image;
    cut1 = floor(Vs/s(i));
    cut2 = Ss;
    strip(1:cut1, 1:cut2) = zeros(cut1, cut2);
    path = strcat(folder, ['Vcrop_Mkd_img_',num2str(s(i)),'.tif']);
    imwrite(strip, path);
end

for i = 1:length(s)
    square = Image;
    cut1 = floor(Vs/s(i));
    cut2 = floor(Ss/s(i));
    square(1:cut1, 1:cut2) = zeros(cut1, cut2);
    path = strcat(folder, ['VScrop_Mkd_img_',num2str(s(i)),'.tif']);
    imwrite(square, path);
end

attack = 'An attack by cropping.';