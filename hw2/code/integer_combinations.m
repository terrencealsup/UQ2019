function V = integer_combinations(d, total)
% integer_combinations Return the list of all non-negative integer-valued 
% vectors whose sum is total.
%
% Done by recursion.
% total >= d must be an integer.
%
% Author: Terrence Alsup



if d == 1
    % Only 1 dimension.
    V = total;
else
    
    % Loop over all possible non-negative integer values that the first
    % component could take.
    V1 = integer_combinations(d-1, total-1);
    n = size(V1, 1); % Number of integer combinations for d-1 variables.
    V = [ones(n,1), V1];
    
    for k=2:total-d+1
        V1 = integer_combinations(d-1, total-k);
        n = size(V1, 1);
        V = [V; [k*ones(n,1), V1]];
    end
end

end

