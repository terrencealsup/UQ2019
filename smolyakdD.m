function Qf = smolyakdD(level, d, f)
% smolyakdD Computes the sparse grid points and quadrature weights.

Qf = 0;
for k=d:level+d-1
    V = integer_combinations(d, k);
    for i=1:size(V,1)
        if size(V,1) == 1
            [X,W] = incdD(V);
        else
            [X,W] = incdD(V(i,:));
        end
        Qf = Qf + W*f(X)';
    end
end

end

