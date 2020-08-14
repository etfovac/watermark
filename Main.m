close all;  clc, clear variables
 
% Ver.1.0 2009, Ver.1.1 2020
% Author: Nikola Jovanovic
% Repo: https://github.com/etfovac/watermark
%
% Use the simple Menu to control the program flow, but mind the order of the steps. 
% Unmarked image has to be grayscale. If a color image is selected,  
% it is coverted into grayscale image.
    
global K block_dim Level factor Vs Ss hdim_wmark wdim_wmark
% TODO: Get rid of globals
output_folder = 'output\\';
step = 0;
the_end = 8;

while step ~= the_end
    
    step = menu('Image Watermarking Procedure',...
    '1. Read unmarked intensity image',...
    '2. Read the watermark (binary image)',...
    '3. Select transformation (DCT / DWT)',...
    '4. Mark the image',...
    '5. Attack/degrade the marked image',...
    '6. Read a marked intensity image',...
    '7. Detect and extract the watermark image',...
    ' Exit ');
    

    K = 14;    % "watermark strength" in [%] 
    % ie. percentage of transformation coefficients change
    block_dim = 8; % DCT block size is 8x8
    Level = 3; % Level of decomposition for Wavelet transformation
    % Level = round(log10(block_dim)/log10(2))
    
    % 1. Read unmarked intensity image ----------------------------
    if step == 1
        img_path = 'input\\lena_gray_512.tif';
        Unmarked_image = imread(img_path);
        if length(size(Unmarked_image)) ~= 2
            disp('Image dimensions have to be MxN pixels.');
            Unmarked_image = rgb2gray(Unmarked_image);
            % Enter intensity/grayscale image
        end
        figure(1), imshow(Unmarked_image), title('Unmarked image')
        [Image, Vs, Ss] = adj_image(Unmarked_image, block_dim);
        factor = norm_factor(Image);
        Image = double(Image)/factor;
        % Watermark dimensions
        hdim_wmark = Vs/block_dim;
        wdim_wmark = Ss/block_dim;
        hw_wmark = hdim_wmark * wdim_wmark;
    end
        
    % 2. Read watermark (binary image with pixels 0 or 1) ---------------------------------
    if step == 2
        watermark_path = 'input\\watermark.jpeg';
        tmp_wmark = imread(watermark_path);
        orig_wmark = zeros(size(tmp_wmark));
        tmp_wmark = tmp_wmark/max(max(tmp_wmark));
        above = find(tmp_wmark >= 0.5);
        orig_wmark(above) = ones(size(above));
        figure(2), imshow(orig_wmark), title('Original watermark')
        watermark = adj_wmark(orig_wmark);
    end
    
    % 3. Select method (DCT or Wavelet) ---------------------------------
    if step == 3
        m = 0;
        while m ~= 3
            m = menu('Select method',...
                'DCT', 'Wavelet', 'OK');
            if m == 1
                method = 1;
                disp('DCT')
                break
            end
            if m == 2
                method = 2;
                disp('Wavelet')
                break
            end
        end
    end
        
    % 4. Mark an image (incorporate the watermark) ----------------------
    if step == 4
        % Key for PSS generator
        key = 1682004; %TODO: make it an input
        % MATLAB PSS generator is set to init state def by the key 
        rng(key);
        % PSS Permute the watermark
        a1 = randperm(hw_wmark);
        clear key; % delete key
        a2 = reshape(a1, hdim_wmark, wdim_wmark);
        skrembl_wmark = watermark(a2);
        skrembl_wmark1 = (skrembl_wmark - 0.5)/0.5; % -1 i 1
        % skrembl_wmark1 is type double
        if method == 1
            Marked_image = embed_DCT(Image, skrembl_wmark1, block_dim, K);
        elseif method == 2
            Marked_image = embed_DWT(Image, skrembl_wmark1, Level, K);
        else
            error('\n Error. Unsupported method.');
        end
        figure(5), imshow(Marked_image), title('Marked image')
        Marked_image_uint8 = uint8(Marked_image * factor);
        imwrite(Marked_image_uint8, 'output\\Marked_image.tif');
    end
    
    % 5. Attak/degrade the image --------------------------------------------------
    % no breaks so that combinations are possible
    if step == 5
        k = 0;
        while k ~= 7
            k = menu('Attak/degrade the image',...
                'JPEG compression', 'Brightness',...
                'Contrast','Cropping','Filtering',...
                'Noise','OK');
            if k == 1
                attack = compression(Marked_image_uint8, output_folder);
                %generates images that start with: JPEG_Mkd_img_
            end
            if k == 2
                attack = brightness(Marked_image, output_folder, factor);
                %generates images that start with: Bright_Mkd_img_
            end
            if k == 3
                attack = contrast(Marked_image, output_folder, factor);
                %generates images that start with: Mcon_Mkd_img_
                %generates images that start with: Hcon_Mkd_img_
            end
            if k == 4
                attack = cropping(Marked_image_uint8, output_folder);
                %generates images that start with: Vcrop_Mkd_img_
                %generates images that start with: VScrop_Mkd_img_
            end
            if k == 5
                attack = filtering(Marked_image_uint8, output_folder);
                %generates images that start with: Filt_Mkd_img_
            end
            if k == 6
                attack = noise(Marked_image_uint8, output_folder);
                %generates images that start with: Noise_Mkd_img_
            end
        end
        disp(attack);
    end
    
    % 6. Read marked intensity/grayscale image --------------------------
    if step == 6
        img_file = input('\n Enter marked intensity/grayscale image:   ');
        full_path = strcat(output_folder,img_file);
        Marked_image = imread(full_path);
        if length(size(Marked_image)) ~= 2
            disp('Image dimensions have to be MxN pixels.');
            Marked_image = rgb2gray(Marked_image); % convert to grayscale
        end
        factor = norm_factor(Marked_image);
        Marked_image = double(Marked_image)/factor;
        % Dimensions of unmarked and marked image are the same.
        figure(6),imshow(Marked_image), title('Marked image (read)')
    end
    
    % 7. Detect watermark -----------------------
    if step == 7
        % Key for PSS generator
        key = 1682004;
        %key = input('\n Enter the password:   ');
        rng(key);
        % Undo the permutation of the watermark.
        b1 = randperm(hw_wmark);
        clear key; % delete key
        b2 = reshape(b1, hdim_wmark, wdim_wmark);
        if method == 1
            recovered_watermark = extract_DCT(Image, Marked_image, b2, block_dim, hdim_wmark, wdim_wmark);
        elseif method == 2
            recovered_watermark = extract_DWT(Image, Marked_image, b2, Level, factor, hdim_wmark, wdim_wmark);
        else
            error('\n Error. Unsupported method.');
        end
        figure(7),imshow(recovered_watermark),title('Detected watermark')
        kkor_wmarkova = corr2(watermark, recovered_watermark);
        fprintf('\n Correlation Coefficient of the watermarks   %f', kkor_wmarkova)
        nkor_wmarkova = sum(sum(recovered_watermark .* watermark))/sum(sum(watermark.^2));
        fprintf('\n Normalized Correlation of the watermarks   %f', nkor_wmarkova)
        kkor_slika = corr2(Image, Marked_image);
        fprintf('\n Correlation Coefficient of the images   %f', kkor_slika)
        nkor_slika = sum(sum(Marked_image .* Image))/sum(sum(Image.^2));
        fprintf('\n Normalized Correlation of the images   %f  \n', nkor_slika)
        error = abs(recovered_watermark - watermark);
        br_pogr_bita = sum(sum(error));
        fprintf('\n Num of bit errors in detected watermark %i   ', br_pogr_bita)
        procenat_pogr_bita = (br_pogr_bita/hw_wmark)*100;
        fprintf('\n BER [%%] for detected watermark %f  \n', procenat_pogr_bita)
        disp('*******************************************************')
    end
    %    THE END  -----------------------------------------------------
end
clc