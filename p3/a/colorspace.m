clear;
clc;

% Load image
% img = imread('IMG_1525.heic');
img = imread('IMG_1525.png');
rgb = im2double(img);
% Convert to colorspaces
lab = rgb2lab(rgb);
xyz = rgb2xyz(rgb);
ycbcr = rgb2ycbcr(rgb);
gray = rgb2gray(rgb);
hsv = rgb2hsv(rgb);
% Display RGB channels
figure('Name', 'RGB');
subplot(1,3,1); imshow(rgb(:,:,1)); title('R');
subplot(1,3,2); imshow(rgb(:,:,2)); title('G');
subplot(1,3,3); imshow(rgb(:,:,3)); title('B');
% Display LAB channels
figure('Name', 'LAB');
subplot(1,3,1); imshow(lab(:,:,1), []); title('L');
subplot(1,3,2); imshow(lab(:,:,2), []); title('A');
subplot(1,3,3); imshow(lab(:,:,3), []); title('B');
% Display XYZ channels
figure('Name', 'XYZ');
subplot(1,3,1); imshow(xyz(:,:,1), []); title('X');
subplot(1,3,2); imshow(xyz(:,:,2), []); title('Y');
subplot(1,3,3); imshow(xyz(:,:,3), []); title('Z');
% Display YCbCr channels
figure('Name', 'YCbCr');
subplot(1,3,1); imshow(ycbcr(:,:,1)); title('Y');
subplot(1,3,2); imshow(ycbcr(:,:,2)); title('Cb');
subplot(1,3,3); imshow(ycbcr(:,:,3)); title('Cr');
% Display HSV channels
figure('Name', 'HSV');
subplot(1,3,1); imshow(hsv(:,:,1)); title('H');
subplot(1,3,2); imshow(hsv(:,:,2)); title('S');
subplot(1,3,3); imshow(hsv(:,:,3)); title('V');
% Display Grayscale
figure('Name', 'Grayscale');
imshow(gray); title('Gray');

% Display selected channels
figure('Name', 'Selected Channels');
subplot(1,4,1); imshow(xyz(:,:,3), []); title('XYZ - Z');
subplot(1,4,2); imshow(lab(:,:,3), []); title('LAB - B');
subplot(1,4,3); imshow(hsv(:,:,2)); title('HSV - S');
subplot(1,4,4); imshow(gray); title('Grayscale');