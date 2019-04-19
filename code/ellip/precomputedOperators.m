% precompute operators for block with 16

for level = 2:7
    xi = zeros(1, 6);
    ACell = {};
    xi(1) = 1;
    [ACell{1}, f] = genOperators2D(@(X, Y)coeffFun2DBlocks6(xi, X, Y), level);
    for i=2:length(xi)
        disp(num2str(i));
        xi = zeros(1, 6);
        xi(i) = 1;
        ACell{i} = genOperators2D(@(X, Y)coeffFun2DBlocks6(xi, X, Y), level);
    end
    
    eval(['save operatorsBlocks6_level', num2str(level), '.mat ACell f']);
    
end