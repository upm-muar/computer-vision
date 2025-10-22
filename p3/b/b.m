clear;
clc;

img = imread('IMG_1525.png');
img = im2gray(img);

figure(1)
subplot(2, 2, 1)
imshow(img);
title('Original')

Kma = 1/9*ones(3, 3);
output = conv2d(img, Kma);

subplot(2, 2, 2)
imshow(output)
title('Blurred - Moving Average Kernel')

Gx = [-1 0 1; -2 0 2; -1 0 1];
output = conv2d(img, Gx);

subplot(2, 2, 3)
imshow(output)
title('Contours - Sobel Operator')

Gy = Gx';
output = conv2d(img, Gy);

subplot(2, 2, 4)
imshow(output, [])
