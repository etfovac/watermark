function wmark = adj_wmark(w, hdim_wmark, wdim_wmark)
% 
% Dim of original wmark
        Vz = size(w,1); % h
        Sz = size(w,2); % w
% Adjust wmark dimensions
        wmark1 = []; % init
        if Vz < hdim_wmark
            n = floor(hdim_wmark/Vz);
            for i = 1:n
                wmark1 = [wmark1; w]; % repeat verticaly
            end
            filler = w(1:mod(hdim_wmark,Vz), :);
            wmark1 = [wmark1; filler];
        else
            wmark1 = w(1:hdim_wmark, :); % crop
        end
        wmark2 = []; % init
        if Sz < wdim_wmark
            m = floor(wdim_wmark/Sz);
            for j = 1:m
                wmark2 = [wmark2, wmark1]; % repeat horizontaly
            end
            filler = wmark1(:, 1:mod(wdim_wmark,Sz));
            wmark2 = [wmark2, filler]; 
        else
            wmark2 = wmark1(:, 1:wdim_wmark); % crop
        end
        wmark = wmark2;
        if ((Vz ~= hdim_wmark) || (Sz ~= wdim_wmark))
            fprintf('\n Watermark dimensions are set to: %ix%i.', ...
                hdim_wmark, wdim_wmark);
            imwrite(uint8(wmark),'w.bmp');
        end  