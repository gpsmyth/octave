function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% Initialize some useful values
m = length(y); % number of training examples

% You need to return the following variables correctly 
J = 0;
grad = zeros(size(theta));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%
log_scale = 1/(2*m);
reg_scale = lambda/(2*m);

% From ex1 computeCost.m
% ./mlclass-ex1-006/mlclass-ex1/computeCost.m
hyp = X * theta;
errsq = (hyp -y).^2;
total_sum = sum(errsq);
%J = (1/(2*m)) * total_sum;
J = log_scale * total_sum;

% regularize theta by removing first value
J = J + (reg_scale * sum(theta(2:end) .^2));

%keyboard;
% regularize theta by removing first value
theta_reg = [0;theta(2:end, :);];


% ./mlclass-ex3-006/mlclass-ex3/lrCostFunction.m
grad = (1 / m) * (X' * (hyp - y));
gradScale = lambda/m;
grad = grad + (gradScale * [0; theta(2:end)]);

% =========================================================================

grad = grad(:);

end
