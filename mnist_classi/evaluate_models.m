clear; clc; close all;

load('Test_digits.mat')

digits = Test_numbers.image;

XTest = reshape(digits, 28, 28, 1, length(digits));

%% Resnet-18 evaluation
% resnet = load('cnn_pretrained_net.mat');
% 
% XTest_resized = zeros(224, 224, 3, size(XTest, 4), 'single');
% 
% YPred = classify(resnet.net, XTest_resized);
% YPred = str2double(string(YPred));
% accuracy = sum(YPred == YTest) / numel(YTest);
% disp("MLP Test Accuracy: " + string(accuracy * 100) + "%");
% 
% figure('Name', 'Confusion Matrix')
% cm = confusionchart(YTest, YPred, ...
%     'RowSummary', 'row-normalized', ...
%     'ColumnSummary', 'column-normalized');
% cm.Title = 'Confusion Matrix';
% cm.XLabel = 'Predicted Class';
% cm.YLabel = 'True Class';

% class = YPred';
% name = {'A. GAONA'};

% save("1GAONRESNET.mat", "class", "name")

%% MLP evaluation
mlp_net = load('mlp_net.mat');

YPred = classify(mlp_net.net, XTest);
YPred = str2double(string(YPred));
% accuracy = sum(YPred == YTest) / numel(YTest);
% disp("MLP Test Accuracy: " + string(accuracy * 100) + "%");
% 
% figure('Name', 'Confusion Matrix')
% cm = confusionchart(YTest, YPred, ...
%     'RowSummary', 'row-normalized', ...
%     'ColumnSummary', 'column-normalized');
% cm.Title = 'Confusion Matrix';
% cm.XLabel = 'Predicted Class';
% cm.YLabel = 'True Class';

class = YPred';
name = {'A. GAONA'};

save("1GAONMLPv2.mat", "class", "name")

%% CNN evaluation
cnn_net = load('cnn_net.mat');

YPred = classify(cnn_net.net, XTest);
YPred = str2double(string(YPred));
% accuracy = sum(YPred == YTest) / numel(YTest);
% disp("CNN Test Accuracy: " + string(accuracy * 100) + "%");

% figure('Name', 'Confusion Matrix')
% cm = confusionchart(YTest, YPred, ...
%     'RowSummary', 'row-normalized', ...
%     'ColumnSummary', 'column-normalized');
% cm.Title = 'Confusion Matrix';
% cm.XLabel = 'Predicted Class';
% cm.YLabel = 'True Class';

class = YPred';
name = {'A. GAONA'};

save("1GAONCNNv2.mat", "class", "name")
