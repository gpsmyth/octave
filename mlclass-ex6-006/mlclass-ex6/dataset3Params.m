function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
error_min = Inf;
C_vec = [0.01 0.03 0.1 0.3 1 3 10 30];
sigma_vec = [0.01 0.03 0.1 0.3 1 3 10 30];

C_len = length(C_vec);
sigma_len = length(sigma_vec);

for C_index = 1:C_len
    % current_C = C_vec(C_index);
    C = C_vec(C_index);
    for sigma_index = 1:sigma_len
        %current_sigma = sigma_vec(sigma_index);
        sigma = sigma_vec(sigma_index);
        % model= svmTrain(X, y, current_C, @(x1, x2) gaussianKernel(x1, x2, current_sigma));
        model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
        predictions = svmPredict(model, Xval);
        pred_err = mean(double(predictions ~= yval));
        %fprintf( ' prediction error is: %f on [C, sigma] = [%f %f]\n', pred_err, current_C, current_sigma );
        fprintf( ' prediction error is: %f on [C, sigma] = [%f %f]\n', pred_err, C, sigma );

        % Identify the best prediction error to C and sigma
        if pred_err < error_min
            error_min = pred_err;
            min_C = C;
            %C = current_C;
            %sigma = current_sigma;
            min_sigma = sigma;
            fprintf( '\t new min error is: %f on [C, sigma] = [%f %f]\n', error_min, C, sigma );
        endif
    endfor
endfor

sigma = min_sigma;
C = min_C;
% Noe the [ ] around the processing of fprintf especially when a wrapped line is used.
fprintf (['\n Processing is now complete, best values identified for [C sigma] are '...
                                  '[%f %f] on prediction error of %f\n'], C, sigma, error_min );
% fprintf(['best values identified for [C sigma] are:[%f %f] '...
%  '\n(on prediction error of %f)\n'], C, sigma, error_min );



% =========================================================================

end
