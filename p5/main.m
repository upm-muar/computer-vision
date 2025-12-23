% Alumno: Alvaro Gaona

clear, clc, close all;

I = imread('cameraman.tif');

%% Fourier Transform
F = fft2(I);

magnitude = log(1+abs(fftshift(F)));
phase = angle(F);

figure('Name', 'Original')
imshow(I)
title('Original', 'Interpreter', 'latex', 'FontSize', 14)

figure('Name', 'Fourier Transform')
subplot(2, 1, 1)
imshow(magnitude, [])
title('Magnitude', 'Interpreter', 'latex', 'FontSize', 14)

subplot(2, 1, 2)
imshow(phase)
title('Phase', 'Interpreter', 'latex', 'FontSize', 14)

%% Reconstruction
J = ifft2(F);
J_no_phase = ifft2(abs(F)); 

J_magnitude = ifft2(exp(1i * phase));

figure('Name', 'Reconstruction')

subplot(1, 3, 1)
imshow(J, [])
title('Reconstruction using IFFT', 'Interpreter', 'latex', 'FontSize', 12)

subplot(1, 3, 2)
imshow(J_no_phase, [])
title('Reconstruction ($\phi = 0$)', 'Interpreter', 'latex', 'FontSize', 12)

subplot(1, 3, 3)
imshow(J_magnitude, [])
title('Reconstruction ($A = 1$)', 'Interpreter', 'latex', 'FontSize', 12)

%% Filtering
[M, N] = size(I);

D0 = 30;

[u,v] = meshgrid(-N/2:N/2-1, -M/2:M/2-1);
D = sqrt(u.^2 + v.^2);
H = double(D <= D0);

Fshift = fftshift(F);
Ffilt = Fshift .* H;
Ifilt = real(ifft2(ifftshift(Ffilt)));

figure('Name', 'Filtering')
subplot(2, 1, 1)
imshow(H)
title('Low-pass Filter', 'Interpreter', 'latex', 'FontSize', 12)

subplot(2, 1, 2)
imshow(Ifilt, [])
title('Filtered Reconstruction', 'Interpreter', 'latex', 'FontSize', 12)

