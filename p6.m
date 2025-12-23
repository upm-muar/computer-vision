clear; clc; close all;

%% Camera Settings
cam = webcam('MacBook Pro Camera');
boxImage = im2gray(imresize(imread('IMG_2187.jpg'),0.2));

%% SURF Features
boxPoints = detectSURFFeatures(boxImage);
[boxFeatures, boxPoints] = extractFeatures(boxImage, boxPoints);

figure('Name', 'Live Acquisition')
while true
    sceneImage = im2gray(snapshot(cam));
  
    scenePoints = detectSURFFeatures(sceneImage);
    [sceneFeatures, scenePoints] = extractFeatures(sceneImage, scenePoints);
    boxPairs = matchFeatures(boxFeatures, sceneFeatures);
    matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
    matchedScenePoints = scenePoints(boxPairs(:, 2), :);

    imshow(sceneImage)
    hold on;

    hold on;
    if size(boxPairs, 1) >= 3
        [tform, ~, ~] = estgeotform2d(matchedBoxPoints, matchedScenePoints, 'affine');
        boxPolygon = [1, 1;...                           % top-left
            size(boxImage, 2), 1;...                 % top-right
            size(boxImage, 2), size(boxImage, 1);... % bottom-right
            1, size(boxImage, 1);...                 % bottom-left
            1, 1];                   % top-left again to close the polygon

        newBoxPolygon = transformPointsForward(tform, boxPolygon); 
        line(newBoxPolygon(:, 1), newBoxPolygon(:, 2), Color='y');
    end
    hold off;
end



