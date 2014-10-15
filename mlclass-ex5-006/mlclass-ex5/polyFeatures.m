function [X_poly] = polyFeatures(X, p)
%POLYFEATURES Maps X (1D vector) into the p-th power
%   [X_poly] = POLYFEATURES(X, p) takes a data matrix X (size m x 1) and
%   maps each example into its polynomial features where
%   X_poly(i, :) = [X(i) X(i).^2 X(i).^3 ...  X(i).^p];
%


% You need to return the following variables correctly.
X_poly = zeros(numel(X), p);

% ====================== YOUR CODE HERE ======================
% Instructions: Given a vector X, return a matrix X_poly where the p-th 
%               column of X contains the values of X to the p-th power.
%
% 
%keyboard;
%X_poly = fliplr(vander(X));
%X_poly = vander(fliplr(X(:, 2:end)));
%tmp_poly = fliplr(vander(X,p));
%X_poly = fliplr(vander(X,p));
%X_poly = fliplr(vander(X):, 2:end);
%X_poly = tmp_poly(:,2:end);

% =========================================================
% From url https://class.coursera.org/ml-006/forum/search?q=polyFeatures#12-state-query=polyFeatures
% test case
% =========================================================
% polyFeatures([2; 5; 7], 4)
% ans =
% 
%         2        4        8       16
%         5       25      125      625
%         7       49      343     2401
% =========================================================
%keyboard;
% fliplr(vander([2; 5; 7],5))(:,2:end)

X_poly = fliplr(vander(X,p+1))(:,2:end);
% =========================================================
% for loop interpreatation
% =========================================================
%     X_poly(:,1) = X;
%     for i=2:p
%         X_poly(:,i) = X.*X_poly(:,i-1);
% end
% =========================================================

% =========================================================================

end
