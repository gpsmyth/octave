function [lambda_vec, error_train, error_val] = ...
    validationCurve(X, y, Xval, yval)
%VALIDATIONCURVE Generate the train and validation errors needed to
%plot a validation curve that we can use to select lambda
%   [lambda_vec, error_train, error_val] = ...
%       VALIDATIONCURVE(X, y, Xval, yval) returns the train
%       and validation errors (in error_train, error_val)
%       for different values of lambda. You are given the training set (X,
%       y) and validation set (Xval, yval).
%

% Selected values of lambda (you should not change this)
lambda_vec = [0 0.001 0.003 0.01 0.03 0.1 0.3 1 3 10]';

% You need to return these variables correctly.
error_train = zeros(length(lambda_vec), 1);
error_val = zeros(length(lambda_vec), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return training errors in 
%               error_train and the validation errors in error_val. The 
%               vector lambda_vec contains the different lambda parameters 
%               to use for each calculation of the errors, i.e, 
%               error_train(i), and error_val(i) should give 
%               you the errors obtained after training with 
%               lambda = lambda_vec(i)
%
% Note: You can loop over lambda_vec with the following:
%
%       for i = 1:length(lambda_vec)
%           lambda = lambda_vec(i);
%           % Compute train / val errors when training linear 
%           % regression with regularization parameter lambda
%           % You should store the result in error_train(i)
%           % and error_val(i)
%           ....
%           
%       end
%
%
m = length(lambda_vec);
%% for i = 1:m
%%     % keyboard;
%%     lambda = lambda_vec(i);
%% %    theta = trainLinearReg( X(1:i, :), y(1:i), lambda );
%%     % error_train(i) = linearRegCostFunction( X(1:i, :), y(1:i), theta, 0 );
%% % learningCurve(X, y, Xval, yval, lambda)
%% % validationCurve(X, y, Xval, yval)
%% %    error_train(i) = learningCurve( X, y, theta, lambda );
%% %    error_val(i) = learningCurve( Xval, yval, theta, lambda );
%% [error_train(i) error_val(i)] = learningCurve(X, y, Xval, yval, lambda);
%% end

for i = 1:m
    lambda = lambda_vec(i);
    % Lambda is only used to prevent the theta values from causing over-fitting, when we train theta.
    % ================================================================================================
    % After you have theta, we want to use our Cost Function to measure the costs for the training set 
    % and the validation set. Since we already have theta, we do not want to calculate the regularized cost - 
    % that is built into theta already. So we set the lambda parameter to 0 when using our Cost Function 
    % to measure the cost for the training set and the validation set.
    % ================================================================================================
    % remove subindexes from X and y in your error_train calcs.
    % Because now you are using your whole training set in every iteration...
    % Previously was
    % theta = trainLinearReg( X(1:i, :), y(1:i), lambda );
    % now is,
    % keyboard;
    theta = trainLinearReg( X, y, lambda );
    
    % Previously was 
    % error_train(i) = linearRegCostFunction( X(1:i, :), y(1:i), theta, 0 );
    % now is,
    error_train(i) = linearRegCostFunction( X, y, theta, 0 );
    error_val(i) = linearRegCostFunction( Xval, yval, theta, 0 );
end

% =========================================================================

end
