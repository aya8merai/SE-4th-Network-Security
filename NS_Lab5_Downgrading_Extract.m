clc;
clear;

% ---------------------------------
% ------ Downgrading Extract ------
% ---------------------------------

I_stego = (imread('S:\NetworkSecurity\DownstegoImg.png'));

[row, col] = size(I_stego);

I_stego_bin = dec2bin(I_stego);

secret_bin = dec2bin(zeros(row*col, 1));
for rfb=1:row*col
        cfb = 1;
        % Take the Most Segnegicant 4-Bits of the Secret img From the LSB of the Stego in reverse order
        for MSB_secret=8:-1:5 
            secret_bin(rfb, cfb) = I_stego_bin(rfb, MSB_secret);             
            cfb = cfb + 1;
        end    
end

Isecret = bin2dec(secret_bin);
Isecret = reshape(Isecret, row, col);
imwrite(Isecret, 'S:\NetworkSecurity\DownstegoExtractedImg1.png');

figure;
subplot(1,2,1);imshow(I_stego);title('Stego img');
subplot(1,2,2);imshow(Isecret);title('Secret img');
