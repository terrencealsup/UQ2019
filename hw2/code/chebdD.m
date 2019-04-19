function [X, W] = chebdD(l)
% chebdD Compute the points and weights corresponding to the product rule.
%
% Compute the points and weights using recursion.
%
% Author: Terrence Alsup

% Get the dimension.
d = length(l);

% Recursive step.
if d <= 1
    % The base case.
    [X, W] = cheb1D(l);
else
    % Get the first dimension.
    [x1, w1] = cheb1D(l(1));
    
    % Get the remaining dimensions.
    [Xd, Wd] = chebdD(l(2:d));
    
    % Quadrature points are stored as column vectors.
    
    n1 = length(x1); % Number of points in the first dimension.
    ndm1 = length(Xd(1,:)); % Total number of points in d-1 dimensions.
    
    X = zeros(d, n1*ndm1);
    W = zeros(1, n1*ndm1);
    
    for i=1:n1
        % Stack the first dimension on top.
        X(:,(i-1)*ndm1+1:i*ndm1) = [x1(i) * ones(1, ndm1); Xd];
        % Now compute the weights.
        W((i-1)*ndm1+1:i*ndm1) = w1(i) * Wd;
    end
end


end

