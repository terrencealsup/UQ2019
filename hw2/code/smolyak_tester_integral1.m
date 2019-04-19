clear; clc;
format shortE;
% Test the Smolyak quadrature implementation for the first integral.

for d=1:6
    for level=4:2:10
        Q = smolyakdD(level, d, @f1);
        rel_err = abs(Q-1);
        fprintf('Relative Error for d = %d, level = %d: %f\n',d,level,rel_err);
    end
end