function [mu sigma2] = estimateGaussian(X)
%ESTIMATEGAUSSIAN This function estimates the parameters of a 
%Gaussian distribution using the data in X
%   [mu sigma2] = estimateGaussian(X), 
%   The input X is the dataset with each n-dimensional data point in one row
%   The output is an n-dimensional vector mu, the mean of the data set
%   and the variances sigma^2, an n x 1 vector
% 

% Useful variables
[m, n] = size(X);

% You should return these values correctly
mu = zeros(n, 1);
sigma2 = zeros(n, 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the mean of the data and the variances
%               In particular, mu(i) should contain the mean of
%               the data for the i-th feature and sigma2(i)
%               should contain variance of the i-th feature.
%
%keyboard;
% ============================================================
% You can calculate the mean of X with one call to the mean() function. 
% That gives you a row vector, of the mean for every column. 
% Save that as the "mu" variable, it's one of the things you need to return.
% - Now expand that row into a matrix of duplicated rows, by multiplying 
%   by a column of 1st (size m x 1). You can also do this using repmat(), 
%   but I find multiplying by a column of 1st is easier.
% - Now you can calculate sigma2 by performing the sumsq() of 
%   (X - the mu matrix), scaled by 1/m.
mu = mean( X );
x_ones = ones(size(X, 1),1) * mu;
sigma2 = (1/m)* sumsq(X - x_ones);

% =============================================================
% Another solution.
% var(X, 1) divides with 1/m wheras 
% var(X, 0) divides with 1/(m - 1) hence normalizes with m-1
% =============================================================
% mu = mean(X)';
% sigma2 = var(X, 1)';

% =============================================================
% X = bsxfun(@minus, X, mu(:)');


end
