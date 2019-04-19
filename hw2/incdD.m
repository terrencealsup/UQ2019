function [X, W] = incdD(l)
% incdD Return the points and weights of the increment delta_k.

% Get the dimension.
d = length(l);

if d <= 1
    if l == 1
        [X, W] = cheb1D(l);
    else
        % Quadrature points will be the ones of the higher level.
        [X, W] = cheb1D(l);
        [~, W1] = cheb1D(l-1);
        % Quadrature weights only need to be changed for the common points.
        n = 2^l + 1;
        W(1:2:n) = W(1:2:n) - W1;
    end
else
    % Get the first dimension.
    [x1, w1] = incdD(l(1));
    
    % Get the remaining dimensions.
    [Xd, Wd] = incdD(l(2:d));
    
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

