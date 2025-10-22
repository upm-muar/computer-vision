clc;
clear;

% filename = 'IMG_1525.heic';
filename = 'IMG_1525.png';

info = imfinfo(filename);
img = imread(filename);
img = im2gray(img);

[rows, cols] = size(img);

DFT = log(abs(fftshift(fft2(img))));

class_i = class(img); % Store original data type

% Create the query grid for the final, full-size image
[xli, yli] = meshgrid(1:cols, 1:rows);

% Compute the Fmax out of the DFT
Fmax = 2*max(DFT, [], 'all');

% --- Reconstruction 1 ---
Fs = 2*Fmax;
Ts = 1/Fs;
sampleRateX = floor(Ts*cols);
sampleRateY = floor(Ts*rows);

sampleRate1 = max(sampleRateX, sampleRateY);

Z1 = img(1:sampleRate1:end, 1:sampleRate1:end);
[x1, y1] = meshgrid(1:sampleRate1:cols, 1:sampleRate1:rows);
recons1 = cast(interp2(x1, y1, double(Z1), xli, yli, 'linear'), class_i);

dft_Z1 = fftshift(fft2(double(Z1)));

% --- Reconstruction 2 ---
Fs = Fmax;
Ts = 1/Fs;
sampleRateX = floor(Ts*cols);
sampleRateY = floor(Ts*rows);

sampleRate2 = max(sampleRateX, sampleRateY);

Z2 = img(1:sampleRate2:end, 1:sampleRate2:end);
[x2, y2] = meshgrid(1:sampleRate2:cols, 1:sampleRate2:rows);
recons2 = cast(interp2(x2, y2, double(Z2), xli, yli, 'linear'), class_i);

dft_Z2 = fftshift(fft2(double(Z2)));

% --- Reconstruction 3 ---
sampleRate3 = sampleRate2;

Z3_wo = imresize(img, 1/sampleRate3, 'Antialiasing', false);
Z3 = imresize(img, 1/sampleRate3, 'Antialiasing', true);
[new_rows_Z3, new_cols_Z3] = size(Z3);
x_coords_Z3 = linspace(1, cols, new_cols_Z3);
y_coords_Z3 = linspace(1, rows, new_rows_Z3);
[x3, y3] = meshgrid(x_coords_Z3, y_coords_Z3);
recons3 = cast(interp2(x3, y3, double(Z3), xli, yli, 'linear'), class_i);

% --- Final Plotting ---
figure(1)
subplot(3, 3, 1)
imshow(Z1);
title(['Sample rate $= ', num2str(sampleRate1), '$', ' (oversampled)'], 'interpreter', 'latex');

subplot(3, 3, 2)
imshow(log(1 + abs(dft_Z1)), []);
title('Downsampled Space', 'interpreter', 'latex');

subplot(3, 3, 3)
imshow(recons1);
title('Reconstructed', 'interpreter', 'latex');
 
subplot(3, 3, 4)
imshow(Z2);
title(['Sample rate $= ', num2str(sampleRate2), '$', ' (downSampled)'], 'interpreter', 'latex');

subplot(3, 3, 5)
imshow(log(1 + abs(dft_Z2)), []);
title('Downsampled Space', 'interpreter', 'latex');

subplot(3, 3, 6)
imshow(recons2);
title('Reconstructed', 'interpreter', 'latex');

figure(1)
subplot(3, 3, 7)
imshow(Z3_wo);
title('Downsampled Image w/o Antialiasing', 'interpreter', 'latex');

subplot(3, 3, 8)
imshow(Z3);
title('Downsampled Space w/ Antialiasing', 'interpreter', 'latex');

subplot(3, 3, 9)
imshow(recons3);
title('Reconstructed', 'interpreter', 'latex');

figure(2)
mesh(DFT); colormap hot;
title('Discrete Fourier Transform of the image', 'interpreter', 'latex')