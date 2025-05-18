clc;
clear;

% -------------------------------------------
% ------ Downgrading Extract [3,4,5,6] ------
% -------------------------------------------

% قراءة الصورة
I_stego = (imread('S:\NetworkSecurity\DownstegoImg.png'));
% أخذ أبعادها
[row, col] = size(I_stego);
% تحويلها إلى باينري
I_stego_bin = dec2bin(I_stego,8);
% نسوي مصفوفة باينري كلها أصفار للصورة المستخرجة
secret_bin = dec2bin(zeros(row,col), 8);

for i=1:length(secret_bin)
%     أخذ العناصر من العنصر 6 وتناقص (حتى ناخذها معكوسة) إلى الـ3 
%    ونخليها بمكان أول 4 بالصورة المستخرجة
        secret_bin(i, 1:4) = I_stego_bin(i, 6:-1:3);   
end
% نحول الصورة المستخرجة إلى ديسيمال
Isecret = bin2dec(secret_bin);
% نخلي طولها وعرضها مثل أبعاد الصورة الأصلية
Isecret = reshape(Isecret, row, col);

% عرض الصورتين
figure;
subplot(1,2,1);imshow(I_stego);title('Stego img');
subplot(1,2,2);imshow(Isecret, []);title('Secret img');
