function Z = coeffFun2DBlocks6(xi, X, Y)
% In
%   xi      ...     parameter size 5
%   X, Y    ...     coordinates (with meshgrid)
% Out
%   coeff   ...     coefficient


Z = zeros(size(X));

Z(0 <= Y < 1/6) = xi(1);

Z(1/6 <= Y < 2/6) = xi(2);

Z(2/6 <= Y < 3/6) = xi(3);

Z(3/6 <= Y < 4/6) = xi(4);

Z(4/6 <= Y < 5/6) = xi(5);

Z(5/6 <= Y <= 1) = xi(6);

end