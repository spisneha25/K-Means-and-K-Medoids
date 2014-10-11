function [class, centroid] = mykmedoids(pixels, K)
    mincost = Inf;
    k = K;
    [m, n] = size(pixels);
    maxcomb = 50;
    for i = 1:maxcomb
            uniquecheck = 0;
            while true
                r = randperm(m);
                comb = r(1:K);
                ind = reshape(comb.', [], 1);
                c = permute(reshape(pixels(ind,:).',size(pixels,2), K, []), [2 1 3]);
                u = unique(c, 'rows');
                if (size(c) == size(u))
                    break;
                else
                    uniquecheck = uniquecheck + 1;
                end
                if uniquecheck > 50
                    k = k - 1;
                    uniquecheck = 0;
                end
            end 
            d = euclid_distance(pixels', c');
            distance = min(d, [], 2);
            Cost = sum(distance);
            if mincost > Cost
                mincost = Cost;
                [final_distance, class] = min(d, [], 2);
                centroid = c;
            end
    end
    [sx, sy] = size(centroid);
    centroid = vertcat(centroid, zeros(K-sx, 3) + Inf);
    class = class';
end



    
    

