clear;
clc;
close all;
img = imread('../assets/IMG_1525.png');
img = imresize(img, 0.2);

rgb = im2double(img);

% rgb_noise = imnoise(rgb, 'salt & pepper', 0.02);
% rgb_filt = medfilt3(rgb_noise, [3 3 1]);

rgb_noise = imnoise(rgb, 'gaussian', 0.1);
h = fspecial('average', [9 9]);
rgb_filt = imfilter(rgb_noise, h); % 3x3 kernel

I = rgb2lab(rgb_filt);

%% Extract LAB channels
b_channel = I(:, :, 3);

%% Manual binarization
b_lower = 3;
b_upper = 20;
mask = (b_channel >= b_lower) & (b_channel <= b_upper);

%% Object Extraction
mask3d = repmat(mask, [1, 1, 3]);

% Extracted object w/ white background
white_bg_img = img;
white_bg_img(mask3d) = 255;

% Extracted object w/ black background
black_bg_img = img;
black_bg_img(mask3d) = 0;

figure('Name', 'Object Extraction')
subplot(1,2,1)
imshow(rgb)
title('Original', 'interpreter', 'latex', 'FontSize', 14)

subplot(1,2,2)
imshow(black_bg_img)
title('Extracted Object w/ gaussian noise', 'interpreter', 'latex', 'FontSize', 14)