clear; clc; close all;

set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');

[XTrain,YTrain,~] = digitTrain4DArrayData;
[XTest,YTest,~] = digitTest4DArrayData;

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
    ValidationData={XTest,YTest}, ...
    ValidationFrequency=10, ...
    Plots='training-progress');

net = trainNetwork(XTrain, YTrain, layers, options);

YPred = classify(net, XTest);
accuracy = sum(YPred == YTest) / numel(YTest);
disp("Test Accuracy: " + string(accuracy * 100) + "%");

figure('Name', 'Confusion Matrix')
cm = confusionchart(YTest, YPred, ...
    'RowSummary', 'row-normalized', 'ColumnSummary', 'column-normalized');
cm.Title = 'Confusion Matrix';
cm.XLabel = 'Predicted Class';
cm.YLabel = 'True Class';

save('cnn_net.mat', 'net')
