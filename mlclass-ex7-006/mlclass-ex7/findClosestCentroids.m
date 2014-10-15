function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

% You need to return the following variables correctly.
idx = zeros(size(X,1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%
% keyboard;
for i = 1:size(X,1)
    closest_centroid = Inf;
    for k = 1:K
        % norm performs function of
        %    diff = A - B;
        %    distance = sqrt(diff * diff');
        %
        % norm call be done via
        % distance = norm(A - B);
        distance = norm(X(i,:) - centroids(k,:));
%keyboard;
%        distance = distancePoints(X(i,:), centroids(k,:));
        if ( distance < closest_centroid )
            closest_centroid = distance;
            idx(i) = k;
        endif
    end
end

% =============================================================

end
