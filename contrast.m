function attack = contrast(Marked_image, folder, factor)
%-------------------------------------------------------------------------
% Modify contrast
c = [0.5 0.6 0.7 0.9 1.1 1.4 1.5 1.6 1.7 1.8];

for i = 1:length(c)
    con_img_1 = c(i)* Marked_image;
    path = strcat(folder, '\', ['Mcon_Mkd_img_',num2str(c(i)),'.tif']);
    imwrite(uint8(con_img_1 * factor),path);
end

bin = [8 16 32 64 96 128 160 192 224 240];

for i = 1:length(bin)
    h_con_img = histeq(Marked_image, bin(i));
    path = strcat(folder, '\', ['Hcon_Mkd_img_',num2str(c(i)),'.tif']);
    imwrite(uint8(h_con_img * factor),path);
end

attack = 'An attack by contrast change.';