function y = f2(X)

d = size(X,1);

if d == 1
    y = sin(0.5*pi*(X+1));
else
    y = sin(0.5*pi*(X(1,:)+1));
    for i=2:d
        y = y.*sin(0.5*pi*(X(i,:)+1));
    end
end

end

