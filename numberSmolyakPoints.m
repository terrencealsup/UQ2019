function N = numberSmolyakPoints(level, d)
% Compute the number of quadrature points for Smolyak.

N = 0;
for k=d:level+d-1
    V = integer_combinations(d, k);
    for i=1:size(V,1)
        if size(V,1) == 1
            [~,W1] = incdD(V);
        else
            [~,W1] = incdD(V(i,:));
        end
        N = N + length(W1);
    end
end

end

