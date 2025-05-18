clc;
clear;

% ---------------------------------
% ------- Downgrading Hide --------
% ---------------------------------

cover_img = imresize(imread('morphing\baby1.jpg'), 0.3);
secret_img = imresize(imread('morphing\baby2.jpg'), 0.3); 

% تحويل الصورتين إلى رمادية في حال كانت ملونة
if size(cover_img, 3) == 3 
    cover_img = rgb2gray(cover_img);
end
if size(secret_img, 3) == 3 
    secret_img = rgb2gray(secret_img);
end

[r, c] = size(cover_img);

% جعل الصورتين متطابقتين في الحجم
secret_img = imresize(secret_img, [r, c]);

cover_bin = dec2bin(cover_img);
secret_bin = dec2bin(secret_img);

stego_bin = dec2bin([]);
for rfb=1:r*c
        cfb = 1;
        for msb_cover=1: 4
            stego_bin(rfb, cfb) = cover_bin(rfb, msb_cover);            
            cfb = cfb + 1;
        end
        for msb_secret=4:-1:1
            stego_bin(rfb, cfb) = secret_bin(rfb, msb_secret);             
            cfb = cfb + 1;
        end    
end

Istego = bin2dec(stego_bin); % نحولها من ثنائي إلى عشري
Istego = reshape(Istego, r, c); % نحولها إلى شكل وأبعاد الصور الأصلية
imwrite(uint8(Istego), 'S:\NetworkSecurity\DownstegoImg.png'); % خلي مسار المكان الي تريد تخزن بيه الصورة + اسم ملف الصورة الي تريده وامتداده

figure;
subplot(1,3,1);imshow(cover_img);title('cover img');
subplot(1,3,2);imshow(secret_img);title('Secret');
subplot(1,3,3);imshow(Istego, []);title('new img');
