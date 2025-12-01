clear; clc; close all;

load('digits.mat')

XTest = reshape(digits.image, 28, 28, 1, length(digits.image)) / 255;
YTest = categorical(digits.label(:));

%% MLP evaluation
mlp_net = load('mlp_net.mat');

YPred = classify(mlp_net.net, XTest);
accuracy = sum(YPred == YTest) / numel(YTest);
disp("MLP Test Accuracy: " + string(accuracy * 100) + "%");

figure('Name', 'Confusion Matrix')
cm = confusionchart(YTest, YPred, ...
    'RowSummary', 'row-normalized', ...
    'ColumnSummary', 'column-normalized');
cm.Title = 'Confusion Matrix';
cm.XLabel = 'Predicted Class';
cm.YLabel = 'True Class';

class = YPred';
name = {'A. GAONA'};

save("1GAONMLP.mat", "class", "name")

%% CNN evaluation
cnn_net = load('cnn_net.mat');

YPred = classify(cnn_net.net, XTest);
accuracy = sum(YPred == YTest) / numel(YTest);
disp("CNN Test Accuracy: " + string(accuracy * 100) + "%");

figure('Name', 'Confusion Matrix')
cm = confusionchart(YTest, YPred, ...
    'RowSummary', 'row-normalized', ...
    'ColumnSummary', 'column-normalized');
cm.Title = 'Confusion Matrix';
cm.XLabel = 'Predicted Class';
cm.YLabel = 'True Class';

class = YPred';
name = {'A. GAONA'};

save("1GAONCNN.mat", "class", "name")
