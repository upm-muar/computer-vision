img = imread("Lena.jpg");
nSamples = 256;
stepSize = 1/nSamples;

imshow(img);

DFT = log(abs(fftshift(fft2(img))));

figure(1)
mesh(DFT); colormap hot;

Fmax = 32;
Fs = 2*Fmax;
Ts = 1/Fs;
sampleRate = Ts/stepSize;

Z = img(1:sampleRate:end,1:sampleRate:end);

figure(2)
imshow(Z);

class_i = class(Z);
[x1, y1] = meshgrid(1:sampleRate:256);
[xli, yli] = meshgrid(1:256);

recons = cast(interp2(x1, y1, double(Z), xli, yli, 'linear'), class_i);

figure(3)
imshow(recons)

Z_nf = imresize(img, 0.16667, 'Antialiasing', false);

figure(4)
imshow(Z_nf)

Z_f = imresize(img, 0.16667, 'Antialiasing', true);

figure(5)
imshow(Z_f)
