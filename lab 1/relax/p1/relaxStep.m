function gn = relaxStep(go,gSize)
    gSize = size(go);
    gn = zeros(gSize);
    
    for i = 2:gSize(1)-1
        for j = 2:gSize(2)-1
           if (i == ceil(gSize(1)/2) && j == ceil(gSize(2)/2)) %midpoint
                gn(i,j) = go(i,j);
           else
               gn(i,j) = (go(i+1,j)+go(i-1,j)+go(i,j+1)+go(i,j-1))/4;
           end
        end
    end
end