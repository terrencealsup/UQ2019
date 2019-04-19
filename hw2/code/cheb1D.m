function [x, w] = cheb1D(l)
% cheb1D Clenshaw-Curtis points and weights for level l.
%
% Author: Terrence Alsup

n = 2^l + 1; % Number of quadrature points.

% Use the trick that Chebfun uses to compute the quadrature points for 
% better numerical accuracy.
x = sin(pi*(-n+1:2:n-1)/(2*(n-1)));

% Now compute the quadrature weights.
w = zeros(1,n);

% Weights at the endpoints.
w(1) = 1/(n*(n-2));
w(n) = 1/(n*(n-2));

% Now compute the weights at the interior points.
for i=2:n-1
    sum = 0;
    for j=1:(n-1)/2
        term =  cos(2*pi*(i-1)*j/(n-1))/(1-4*j^2); 
        if j == (n-1)/2
            % Last term is halved.
            sum = sum + 0.5*term; 
        else
            sum = sum + term;
        end
    end
    w(i) = 2*(1 + 2*sum)/(n-1);
end

end

