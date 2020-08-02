function zig = podes_ziga(orig_zig)
global vis_ziga sir_ziga
% Dimenzije originalnog ziga
        Vz = size(orig_zig,1); % visina
        Sz = size(orig_zig,2); % sirina
% Podesavanje dimenzija ziga
        zig1 = []; % inicijalizacija
        if Vz < vis_ziga
            n = floor(vis_ziga/Vz);
            for i = 1:n
                zig1 = [zig1; orig_zig]; % zig se ponavlja po vertikali
            end
            dopuna = orig_zig(1:mod(vis_ziga,Vz), :);
            zig1 = [zig1; dopuna];
        else
            zig1 = orig_zig(1:vis_ziga, :); % odsecanje
        end
        zig2 = []; % inicijalizacija
        if Sz < sir_ziga
            m = floor(sir_ziga/Sz);
            for j = 1:m
                zig2 = [zig2, zig1]; % zig se ponavlja po horizontali
            end
            dopuna = zig1(:, 1:mod(sir_ziga,Sz));
            zig2 = [zig2, dopuna]; 
        else
            zig2 = zig1(:, 1:sir_ziga); % odsecanje
        end
        zig = zig2;
        if (Vz ~= vis_ziga) || (Sz ~= sir_ziga)
            fprintf('\n Dimenzije ziga su podesene na: %ix%i.', ...
                vis_ziga, sir_ziga);
            imwrite(uint8(zig),'zig.bmp');
        end  