function Z = coeffFun2DBlocks2(xi, X, Y)
% In
%   xi      ...     parameter size 2
%   X, Y    ...     coordinates (with meshgrid)
% Out
%   coeff   ...     coefficient
%
% Author: Terrence Alsup


% Set the upper half.
Z = xi(1) * ones(size(X));

% Set the lower half.
Z(Y <= 0.5) = xi(2);

end