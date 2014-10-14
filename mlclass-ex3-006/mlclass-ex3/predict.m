function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

% You need to return the following variables correctly 
p = zeros(size(X, 1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Complete the following code to make predictions using
%               your learned neural network. You should set p to a 
%               vector containing labels between 1 to num_labels.
%
% Hint: The max function might come in useful. In particular, the max
%       function can also return the index of the max element, for more
%       information see 'help max'. If your examples are in rows, then, you
%       can use max(A, [], 2) to obtain the max for each row.
%
% 1. add 1's column (first time). 
% 2. calculate X*Theta1'
% 3. call sigmoid function (become layer2)
% 4. add 1's column (second time)
% 5. calculate layer2*Theta2'
% 6. call sigmoid function 
% 7. call max function

% 1- Add ones to the X data matrix into the first column
X = [ones(m, 1) X];
% 2 + 3 calculate X*Theta1' and call sigmoid function (become layer2)
layer2 = sigmoid( X * Theta1');

% 4. add 1's column (second time)
layer2_m = size(layer2, 1);
layer2 = [ones(layer2_m, 1) layer2];

% 5 + 6 calculate layer2*Theta2' and call sigmoid function
output = sigmoid( layer2 * Theta2');
[pred_max pred_idx] = max(output, [], 2 );

p = pred_idx;


% =========================================================================


end
