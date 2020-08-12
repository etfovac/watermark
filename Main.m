close all;  clc, clear variables
 
%   UPRAVLJANJE PROGRAMOM VRSI SE SELEKTOVANJEM PONUDJENIH KORAKA.
%   TREBA VODITI RACUNA O REDOSLEDU IZVRSAVANJA KORAKA. 
%   TREBA SE DRZATI NUMERACIJE.
%
%   WATERMARKING - Oznacavanje slika (2009)
%
% 1. Ucitavanje intenzitetne slike bez ziga
% 2. Ucitavanje ziga (binarne slike)
% 3. Izbor transformacije (DCT ili Wavelet)
% 4. Oznacavanje slike (ugradnja ziga u sliku)
% 5. Napad na sliku
% 6. Ucitavanje intenzitetne slike sa zigom
% 7. Detekcija ziga (izdvajanje ziga iz slike)
%(8)   KRAJ RADA
%
%   Slika koja se oznacava mora biti intenzitetna (grayscale).
% Moze se uneti slika u boji koja ce biti pretvorena u grayscale sliku.
    
global K dim_bloka Nivo faktor Vs Ss vis_ziga sir_ziga

    korak = 0;
    kraj = 8;

while korak ~= kraj
    
    korak = menu(' WATERMARKING - Oznacavanje slika (2009) ',...
    '1.          Ucitavanje intenzitetne slike bez ziga ',...
    '2.             Ucitavanje ziga (binarne slike)         ',...
    '3.          Izbor transformacije (DCT ili Wavelet)',...
    '4.   Oznacavanje slike (ugradnja ziga u sliku) ',...
    '5.                    Napad na sliku                          ',...
    '6.       Ucitavanje intenzitetne slike sa zigom   ',...
    '7.       Detekcija ziga (izdvajanje ziga iz slike) ',...
    ' KRAJ RADA ');
    

    K = 14;    % "Jacina ziga" u [%], tj. procenat promene koeficijenata
    dim_bloka = 8; % Velicina DCT bloka je 8x8
    Nivo = 3; % Nivo dekompozicije kod Wavelet transformacije
    % Nivo = round(log10(dim_bloka)/log10(2))
    
    % 1. Ucitavanje intenzitetne (sive) slike ----------------------------
    if korak == 1
        ime_slike = 'lena_gray_512.tif';
        %ime_slike = input('Unesite naziv originalne slike:   ');
        orig_slika = imread(ime_slike);
        if length(size(orig_slika)) ~= 2
            disp('Slika mora biti dimenzija MxN.');
            orig_slika = rgb2gray(orig_slika);
            % Ulazne slike su intenzitetne slike.
        end
        figure(1), imshow(orig_slika), title('Originalna slika')
        [slika, Vs, Ss] = podes_slike(orig_slika);
        faktor = norm_faktor(slika);
        slika = double(slika)/faktor;
        % Dimenzije ziga
        vis_ziga = Vs/dim_bloka;
        sir_ziga = Ss/dim_bloka;
        vel_ziga = vis_ziga * sir_ziga;
    end
        
    % 2. Ucitavanje ziga (binarne slike) ---------------------------------
    if korak == 2
        ime_ziga = 'ZIG.jpeg';
        %ime_ziga = input('Unesite naziv ziga:   ');
        tmp_zig = imread(ime_ziga);
        orig_zig = zeros(size(tmp_zig));
        tmp_zig = tmp_zig/max(max(tmp_zig));
        preko = find(tmp_zig >= 0.5);
        orig_zig(preko) = ones(size(preko));
        % Zig je binarna slika sa vrednostima piksela 0 i 1.
        figure(2), imshow(orig_zig), title('Originalni zig')
        zig = podes_ziga(orig_zig);
    end
    
    % 3. Izbor metoda (DCT ili Wavelet) ---------------------------------
    if korak == 3
        m = 0;
        while m ~= 3
            m = menu('Izbor metoda',...
                'DCT', 'Wavelet', 'OK');
            if m == 1
                metod = 1;
                disp('DCT')
            end
            if m == 2
                metod = 2;
                disp('Wavelet')
            end
        end
    end
        
    % 4. Oznacavanje slike (ugradnja ziga u sliku) ----------------------
    if korak == 4
        % Kljuc za PSS generator
        kljuc = 1682004;
        %kljuc = input('\n Unesite lozinku:   ');
        % MATLAB-ov PSS generator se podesi 
        % na pocetno stanje odredjeno kljucem.
        rng(kljuc);
        % PSS Permutacija ziga
        a1 = randperm(vel_ziga);
        clear kljuc; % brisanje kljuca
        a2 = reshape(a1, vis_ziga, sir_ziga);
        skrembl_zig = zig(a2);
        skrembl_zig1 = (skrembl_zig - 0.5)/0.5; % -1 i 1
        % skrembl_zig1 je tipa double
        if metod == 1
            Zig_slika = ugradnja_DCT(slika, skrembl_zig1);
        elseif metod == 2
            Zig_slika = ugradnja_DWT(slika, skrembl_zig1);
        else
            error('\n Greska pri izboru metoda.');
        end
        figure(5), imshow(Zig_slika), title('Oznacena slika')
        %slika_uint8 = uint8(slika * faktor);
        %imwrite(slika_uint8, 'Slika.tif');
        Zig_slika_uint8 = uint8(Zig_slika * faktor);
        imwrite(Zig_slika_uint8, 'Oznacena_slika.tif');
    end
    
    % 5. Napad na sliku --------------------------------------------------
    if korak == 5
        k = 0;
        while k ~= 7
            k = menu('Napad na sliku',...
                'JPEG kompresija', 'Modifikacija osvetljaja',...
                'Modifikacija kontrasta','Kropovanje','Filtriranje',...
                'Sum','OK');
            if k == 1
                napad = napad_kompresijom(Zig_slika_uint8);
                %naziv dobijene slike pocinje sa: Kompr_Ozn_slika_
            end
            if k == 2
                napad = napad_osvetljajem(Zig_slika);
                %naziv dobijene slike pocinje sa: Osv_Ozn_slika_
                %naziv dobijene slike pocinje sa: Osv_Ozn_slika_-
            end
            if k == 3
                napad = napad_kontrastom(Zig_slika);
                %naziv dobijene slike pocinje sa: Mkon_Ozn_slika_
                %naziv dobijene slike pocinje sa: Hkon_Ozn_slika_
            end
            if k == 4
                napad = napad_kropovanjem(Zig_slika_uint8);
                %naziv dobijene slike pocinje sa: Vkrop_Ozn_slika_
                %naziv dobijene slike pocinje sa: VSkrop_Ozn_slika_
            end
            if k == 5
                napad = napad_filtriranjem(Zig_slika_uint8);
                %naziv dobijene slike pocinje sa: Filt_Ozn_slika_
            end
            if k == 6
                napad = napad_sumom(Zig_slika_uint8);
                %naziv dobijene slike pocinje sa: Sum_Ozn_slika_
            end
        end
        disp(napad);
    end
    
    % 6. Ucitavanje intenzitetne slike sa zigom --------------------------
    if korak == 6
        ime_slike = input('\n Unesite naziv slike sa zigom:   ');
        ozn_slika = imread(ime_slike);
        if length(size(ozn_slika)) ~= 2
            disp('Slika mora biti dimenzija MxN.');
            ozn_slika = rgb2gray(ozn_slika);
            % Ulazne slike su intenzitetne slike.
        end
        faktor = norm_faktor(ozn_slika);
        ozn_slika = double(ozn_slika)/faktor;
        % Dimenzije oznacene slike i originalne slike su iste.
        figure(6),imshow(ozn_slika), title('Oznacena slika (ucitana)')
    end
    
    % 7. Detekcija ziga (izdvajanje ziga iz slike) -----------------------
    if korak == 7
        % Kljuc za PSS generator
        kljuc = 1682004;
        %kljuc = input('\n Unesite lozinku:   ');
        % MATLAB-ov PSS generator se podesi 
        % na pocetno stanje odredjeno kljucem.
        rng(kljuc);
        % Potrebno za ponistavanje PSS permutacije ziga.
        b1 = randperm(vel_ziga);
        clear kljuc; % brisanje kljuca
        b2 = reshape(b1, vis_ziga, sir_ziga);
        if metod == 1
            rek_zig = izdvajanje_DCT(slika, ozn_slika, b2);
        elseif metod == 2
            rek_zig = izdvajanje_DWT(slika, ozn_slika, b2);
        else
            error('\n Greska pri izboru metoda.');
        end
        figure(7),imshow(rek_zig),title('Detektovani zig')
        % Korelacije originalnog i detektovanog ziga 
        kkor_zigova = corr2(zig, rek_zig);
        fprintf('\n Koeficijent korelacije zigova   %f', kkor_zigova)
        nkor_zigova = sum(sum(rek_zig .* zig))/sum(sum(zig.^2));
        fprintf('\n Normalizovana korelacija zigova   %f', nkor_zigova)
        % Korelacije originalne i oznacene slike
        kkor_slika = corr2(slika, ozn_slika);
        fprintf('\n Koeficijent korelacije slika   %f', kkor_slika)
        nkor_slika = sum(sum(ozn_slika .* slika))/sum(sum(slika.^2));
        fprintf('\n Normalizovana korelacija slika   %f  \n', nkor_slika)
        % Broj pogresnih bitova u detektovanom zigu
        greska = abs(rek_zig - zig);
        br_pogr_bita = sum(sum(greska));
        fprintf('\n Broj pogresnih bita u detektovanom zigu %i   ', ...
            br_pogr_bita)
        procenat_pogr_bita = (br_pogr_bita/vel_ziga)*100;
        fprintf('\n Procenat pogresnih bita u detektovanom zigu %f  \n',...
            procenat_pogr_bita)
        disp('*******************************************************')
        
    end
    
    %    KRAJ RADA  -----------------------------------------------------
end
close all  clc