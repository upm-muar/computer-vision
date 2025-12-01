# Handwritten digits classification

Two neural classifiers have been trained with handwritten digit images
with size 28x28.
These images have normalized values from 0 to 1.

Both the Multi-Layer Perceptron (MLP) and Convolutional Neural Network (CNN) have been
trained with the digits MATLAB dataset, and tested with the `digits.mat` file provided
by the university.

## Results

The training performs really well in both architectures with over 98% of accuracy.
The same performance for other metrics such as precision, and recall. 
The optimizer chosen was ADAM optimizer with multiple options to avoid overfitting, e.g.,
Drop-out layers, L2 regularization, etc.
Overfitting was controlled by doing validation during the training.
So the network did not overfit to the training data.

However, after testing the results with a different dataset (a different domain), 
the performance plummeted drastically to 20% of accuracy.

The reason is that even though the training seems correct, training in a single domain causes
models not to generalize very well under other circumstances.

## Repository

Link to files: https://github.com/upm-muar/computer-vision/tree/main/mnist_classi
