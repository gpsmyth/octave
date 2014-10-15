function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
% -------------------------------------------------------------
% Forward Propagation:
% -------------------------------------------------------------
% We'll start by outlining the forward propagation process. Though this was already accomplished once 
% during Exercise 3, you'll need to duplicate some of that work because computing the gradients requires 
% some of the intermediate results from forward propagation.
% 
% 1 - Expand the 'y' output values into a matrix of single values (see ex4.pdf Page 5). 
% This is most easily done using an eye() matrix of size num_labels, with vectorized indexing 
% by 'y', as in "eye(num_labels)(y,:)". 
% Discussions of this and other methods are available in the Course Wiki - Programming Exercises section. 
% Typical variable name would be "y_matrix".
% 
% 2 - perform the forward propagation:
% a1 equals the X input matrix with a column of 1's added (bias units)
% z2 equals the product of a1 and Θ1
% a2 is the result of passing z2 through g()
% a2 then has a column of 1st added (bias units)
% z3 equals the product of a2 and Θ2
% a3 is the result of passing z3 through g()
% -------------------------------------------------------------

% Expand the 'y' output values into a matrix of single values
y_matrix = eye(num_labels)(y,:);

% ...or
% all_combos = eye(num_labels);    
% y_matrix = all_combos(y,:)         

% 1- Add ones to the X data matrix into the first column - becomes activation layer1
X = [ones(m, 1) X];
act_layer1 = X;
% 2 + 3 calculate X*Theta1' and call sigmoid function (become activation layer2)
z2 = X * Theta1';
act_layer2 = sigmoid( X * Theta1');

% 4. add 1's column (second time) - a2 then has a column of 1s added (bias units)
act_layer2_m = size(act_layer2, 1);
act_layer2 = [ones(act_layer2_m, 1) act_layer2];


act_layer3 = sigmoid( act_layer2 * Theta2');

% -------------------------------------------------------------
% Cost Function, non-regularized
% -------------------------------------------------------------
% 3 - Compute the unregularized cost according to ex4.pdf (top of Page 5), using a3, your y_matrix, 
% and m (the number of training examples). Cost should be a scalar value. 
% If you get a vector of cost values, you can sum that vector to get the cost.
% Update: Remember to use element-wise multiplication with the log() function.
hyp = act_layer3;

cost0 = 0; cost1 = 0;
cost0 = (1 - y_matrix) .* log(1 - hyp);
cost1 = (y_matrix .* log(hyp) );
%keyboard;
J = (1 / m ) * sum(sum(-cost1 - cost0));

% -------------------------------------------------------------
% Regularised cost function section
% -------------------------------------------------------------
% Cost Regularization
% 4 - Compute the regularized component of the cost according to ex4.pdf Page 6, 
%       using Θ1 and Θ2 (excluding the Theta columns for the bias units), along with λ, and m. 
%       The easiest method to do this is to compute the regularization terms separately, 
%       then add them to the unregularized cost from Step 3.
scale = lambda/(2*m);
%keyboard;
% Wrong answer in comments below - kept as reference for myself
%J = J + scale * sum((sum(Theta1(:,2:end) .^2)...
%                  +  sum(sum(Theta2(:,2:end) .^2))));
J = J + scale * (sum(sum(Theta1(:,2:end) .^2))...
                  + sum(sum(Theta2(:,2:end) .^2)));


% -------------------------------------------------------------
% Sigmoid Gradient and Random Initialization
% -------------------------------------------------------------
% 5 - You'll need to prepare the sigmoid gradient function g′(), as shown in ex4.pdf Page 7
% 
% You can submit Part 3 to the grader.

% 6 - Implement the random initialization function as instructed on ex4.pdf, top of Page 8. 
%          You do not submit this function to the grader.

% -------------------------------------------------------------
% Back propagation
% -------------------------------------------------------------
% Step 7 - Now we work from the output layer back to the hidden layer, calculating how bad the errors are. 
% See ex4.pdf Page 9 for reference.
% 
% δ3 equals the difference between a3 and the y_matrix.
% δ2 equals the product of δ3 and Θ2 (ignoring the Θ2 bias units), 
%              then multiplied element-wise by the g′() of z2 (computed back in Step 2).
% 
% Note that at this point, the instructions in ex4.pdf are specific to looping implementations, 
%              so the notation there is different.
% Δ2 equals the product of δ3 and a2. This step calculates the product and sum of the errors.
% Δ1 equals the product of δ2 and a1. This step calculates the product and sum of the errors.
% -------------------------------------------------------------
% keyboard;
% sigma3 = y_matrix .- act_layer3;
% sigma3 = y_matrix - act_layer3;
sigma3 = act_layer3 - y_matrix;
%sigma2 = sigma3 * Theta2(:, 2:end);
sigma2 = (sigma3 * Theta2(:, 2:end)) .* sigmoidGradient(z2);

% keyboard;
% accumulate gradients
delta2 = sigma3' * act_layer2;
delta1 = sigma2' * act_layer1;
% -------------------------------------------------------------
Theta1_grad = ( 1 / m ) .* delta1;
Theta2_grad = ( 1 / m ) .* delta2;

% calculate regularized gradient
%keyboard;
gradScale = lambda/m;
%reg_Theta1 = (lambda/m)*[zeros(size(Theta1, 1), 1) Theta1(:, 2:end)];
%    grad = grad + (gradScale * [0; theta(2:end)]);
% reg_Theta1 = gradScale * [zeros(size(Theta1, 1), 1) Theta1(2:end)];
%    reg_Theta1 = (lambda/m)*[zeros(size(Theta1, 1), 1) Theta1(:, 2:end)];
reg_Theta1 = gradScale * [zeros(size(Theta1, 1), 1) Theta1(:, 2:end)];
reg_Theta2 = gradScale * [zeros(size(Theta2, 1), 1) Theta2(:, 2:end)];
Theta1_grad = Theta1_grad + reg_Theta1;
Theta2_grad = Theta2_grad + reg_Theta2;

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
