clc;
clear;
% filename = 'IMG_1525.heic';
filename = 'IMG_1525.png';
info = imfinfo(filename);

img = imread(filename);

scales = [0.5, 0.3, 0.2, 0.1];

figure(1)
subplot(2, 3, [1, 4])
imshow(img)
title('Original  ($1955 \times 2906$)', 'Interpreter', 'latex', 'FontSize', 14)

positions = [2, 3, 5, 6];
for i = 1:length(scales)
    J = imresize(img, scales(i));
    [h, w, ~] = size(J);
    subplot(2, 3, positions(i))
    imshow(J)
    title(['Scale = ', num2str(scales(i)), ' ($', num2str(w), ' \times ', num2str(h), '$)'], ...
          'Interpreter', 'latex', 'FontSize', 14)
end