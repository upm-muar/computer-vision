clear;
clc;
close all;
img = imread('../assets/IMG_1525.png');
img = imresize(img, 0.2);

rgb = im2double(img);

I = rgb2lab(rgb);

%% Extract LAB channels
L_channel = I(:, :, 1);
a_channel = I(:, :, 2);
b_channel = I(:, :, 3);

%% Histograms
figure('Name', 'Histograms')

subplot(3, 1, 1)
histogram(L_channel, 256);
title('L Channel', 'interpreter', 'latex', 'FontSize', 14);

subplot(3, 1, 2)
histogram(a_channel, 256);
title('A Channel', 'interpreter', 'latex', 'FontSize', 14);

subplot(3, 1, 3)
histogram(b_channel, 256);
title('B Channel', 'interpreter', 'latex', 'FontSize', 14);

%% Manual binarization
b_lower = 3;
b_upper = 20;
mask = (b_channel >= b_lower) & (b_channel <= b_upper);

% Otsu mask
mask_otsu = imbinarize(b_channel);

figure('Name', 'Custom Mask vs Otsu Mask')
subplot(1, 2, 1)
imshow(~mask)
% title('Otsu Mask', 'interpreter', 'latex', 'FontSize', 14)
title('(a)', 'interpreter', 'latex', 'FontSize', 14, 'Units', 'normalized', 'Position', [0.5, -0.05, 0])

subplot(1, 2, 2)
imshow(~mask_otsu)
title('(b)', 'interpreter', 'latex', 'FontSize', 14, 'Units', 'normalized', 'Position', [0.5, -0.05, 0])
% title('Otsu Mask', 'interpreter', 'latex', 'FontSize', 14)

%% Object Extraction
mask3d = repmat(mask, [1, 1, 3]);

% Extracted object w/ white background
white_bg_img = img;
white_bg_img(mask3d) = 255;

% Extracted object w/ black background
black_bg_img = img;
black_bg_img(mask3d) = 0;

figure('Name', 'Object Extraction')
subplot(1,3,1)
imshow(rgb)
title('Original', 'interpreter', 'latex')

subplot(1,3,2)
imshow(white_bg_img)
title('Object w/ white background', 'interpreter', 'latex')

subplot(1,3,3)
imshow(black_bg_img)
title('Object w/ black background', 'interpreter', 'latex')