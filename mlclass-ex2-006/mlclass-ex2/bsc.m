function g = bsc(S, T, t, K, r, s, q)
%BLACK-SCHOLES Compute black-scholes functoon
%   J = BLACK-SCHOLES(...) computes the black-scholes of ....

% You need to return the following variables correctly 
g = zeros(size(z));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the bsc of each value of z (z can be a matrix,
%               vector or scalar).
%g = 1 ./(1 + exp(-z));

keyboard;
d1 = (log(S/K) + ( r - q + 0.5 * s^2) * ( T - t))/ sqrt(T - t);
d2 = d1 - s * sqrt(T -t );
S*exp(-q*(T-t))*pnorm(d1)-K*exp(-r*(T-t))*pnorm(d2);





% =============================================================

end
