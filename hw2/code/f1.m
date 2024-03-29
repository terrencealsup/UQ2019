function y = f1(X)
% f1 The integrand for the first integral.
%
% Author: Terrence Alsup


d = size(X,1);

if d == 1
    y = 2*X.*(X >= 0);
else
    y = (1+1/d)^d * X(1,:).^(1/d) .* (X(1,:) >= 0);
    for i=2:d
        y = y .* X(i,:).^(1/d) .* (X(i,:) >= 0);
    end
end

end