clear;
clc;

A = 5;
Fx = 10;
Fy = 10;

n_samples = 256;
step_size = 1/n_samples;

x = 0:step_size:1-step_size;
y = 0:step_size:1-step_size;

[X,Y] = meshgrid(x,y);

Z = A*sin(2*pi*Fx*X + 2*pi*Fy*Y);

% imshow(Z)

DFT = log(abs(fftshift(fft2(Z))));

% imtool(DFT)

% mesh(DFT); colormap hot;

Fmax = 10;
Fnyquist = 2*Fmax;
Tnyquist = 1/Fnyquist;
nyqSampleRate = Tnyquist/step_size;

% Upsampling
Fnyquist_up = 64;
Tnyquist_up = 1/Fnyquist_up;
sampleRateUp = Tnyquist_up/step_size;

overSampled = Z(1:sampleRateUp:end,1:sampleRateUp:end);

DFT2 = log(abs(fftshift(fft2(overSampled))));
recons = interp2(overSampled,5);

figure(1)
imshow(overSampled);

figure(2)
imshow(DFT2);

figure(3)
imshow(recons)

% Downsampling
Fnyquist_down = 17;
Tnyquist_down = 1/Fnyquist_down;
sampleRateDown = Tnyquist_down/step_size;

subSampled = Z(1:sampleRateDown:end,1:sampleRateDown:end);

DFT3 = log(abs(fftshift(fft2(subSampled))));
recons = interp2(subSampled,5);

figure(4)
imshow(subSampled);

figure(5)
imshow(DFT3);

figure(6)
imshow(recons)