% ---------------------------------
% ---------- LSB Extract ----------
% ---------------------------------

clc;
clear;


% ---------------------------------
%      FOR COVER IMAGE FILE        
% ---------------------------------
% لو حبينا نختاره يدويا من الملفات
% [name, path] = uigetfile('*.*', 'select stego img');
% fileName = strcat(path, name);
% I_stego = imread('fileName');


I_stego = imread('S:\NetworkSecurity\stegoImg8b.png');

[row, col] = size(I_stego);

I_stego_bin = dec2bin(I_stego, 8);

msg_limit = 400; % to make the execution faster
secretmsg_bin_ex = I_stego_bin(1:msg_limit, 8);

[msgr, msgc] = size(secretmsg_bin_ex);
secretmsg_bin8 = dec2bin(zeros(msg_limit, 1));
current = 1;
for i=1:msgr
    for j=1:8
        if current <= msgr
            secretmsg_bin8(i,j) = secretmsg_bin_ex(current);
            current = current + 1;
        end
    end    
end
secret_msg = char(bin2dec(secretmsg_bin8))';

disp('Secret message: ');
disp(secret_msg);
