function mysave( h, fname, sX, sY, genEPS )
%MYSAVE Summary of this function goes here
%   Detailed explanation goes here

if(nargin < 3)
    sX = 5;
    sY = 5;
end
if(nargin < 5)
    genEPS = 0;
end

set(h, 'PaperPosition', [0 0 sX sY]);
set(h, 'PaperSize', [sX sY]);
saveas(h, fname, 'pdf')

if(genEPS)
    if(strcmp(fname(end - 3:end), '.pdf'))
        fname = fname(1:end - 4);
    end
    print(h, '-depsc', fname); 
end

end

