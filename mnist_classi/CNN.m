clear; clc; close all;

set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');

load('digits.mat')

% [XTrain,YTrain,~] = digitTrain4DArrayData;
% [XTest,YTest,~] = digitTest4DArrayData;

XTrain = reshape(digits.image, 28, 28, 1, length(digits.image)) / 255;
YTrain = categorical(digits.label');

n_total = size(XTrain, 4);
n_train = floor(n_total / 2);

XVal = XTrain(:,:,1,n_train+1:end);
YVal = YTrain(n_train+1:end,1);

XTrain = XTrain(:,:,1,1:n_train);
YTrain = YTrain(1:n_train,1);

layers = [
    imageInputLayer([28 28 1])
    convolution2dLayer([3 3], 6, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)
    dropoutLayer(0.2)
    convolution2dLayer(3, 12, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)
    dropoutLayer(0.2)
    convolution2dLayer(3, 24, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer
];

options = trainingOptions('adam', ...
    InitialLearnRate=0.01, ...
    L2Regularization=0.0001, ...
    LearnRateDropFactor=0.1, ...
    LearnRateDropPeriod=2, ...
    MaxEpochs=10, ...
    Shuffle='every-epoch', ...
    ValidationData={XVal,YVal}, ...
    Plots='training-progress');

net = trainNetwork(XTrain, YTrain, layers, options);

YPred = classify(net, XTrain);
accuracy = sum(YPred == YTrain) / numel(YTrain);
disp("Train Accuracy: " + string(accuracy * 100) + "%");

% figure('Name', 'Confusion Matrix')
% cm = confusionchart(YTest, YPred, ...
%     'RowSummary', 'row-normalized', 'ColumnSummary', 'column-normalized');
% cm.Title = 'Confusion Matrix';
% cm.XLabel = 'Predicted Class';
% cm.YLabel = 'True Class';

save('cnn_net.mat', 'net')
