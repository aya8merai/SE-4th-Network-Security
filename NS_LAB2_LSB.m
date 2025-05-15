clc;
clear;

% ---------------------------------
% ----------- LSB Hide ------------
% ---------------------------------


% ---------------------------------
%      FOR COVER IMAGE FILE        
% ---------------------------------
[name, path] = uigetfile('*.*', 'select gray img');
fileName = strcat(path, name);


IMG = imread(fileName);

% Just reducing the size without affecting the ratio to make the execution faster if the image was too large
I = imresize(IMG, 0.5);
% If the image is colored make it gray
if size(I, 3) == 3 
    I = rgb2gray(I);
end

[row, col] = size(I);
I_bin = dec2bin(I);
% ---------------------------------
%      FOR TEXT MESSAGE FILE       
% ---------------------------------
[tName, tPath] = uigetfile('*.txt', 'Select text message file');
tFileName = strcat(tPath, tName);
fp = fopen(tFileName);
% ---------------------------------
%    Preparing the bin Message
% ---------------------------------
[secretmsg, count] = fscanf(fp, '%c');
secretmsg_bin = dec2bin(secretmsg, 8);
[r, c] = size(secretmsg_bin);
x = [];
for i=1:r
    for j=1:c
        x = [x; secretmsg_bin(i, j)];
    end
end
% ---------------------------------
current = 1;

Istego_bin = I_bin(:,:);
for i=1:row*col
        if current ~= count*8
            if x(current) ~= Istego_bin(i,8)
                % Using the LSB in each pixel of the img to hide 1-bit of the secret message
                Istego_bin(i, 8) = x(current);
            end
            current = current + 1;
        end
end

Istego = reshape(bin2dec(Istego_bin), [row, col]);

imwrite(uint8(Istego), 'S:\NetworkSecurity\stegoImg8b.png');


figure;
subplot(1,2,1);imshow(I);title('Original img');
subplot(1,2,2);imshow(uint8(Istego));title('new img');
