function [class, centroid] = mykmeans(pixels, K)
    P = pixels';
    [D, N] = size(P);
    k = K;
    
    if K > N
        error('Error, more clusters than pixels')
    end
    
    uniquecheck = 0;
   while true
        centroids = P(:, randsample(N, k));
        u = unique(centroids', 'rows');
        if (size(centroids') == size(u))
            break;
        else
                uniquecheck = uniquecheck + 1;
        end
        if uniquecheck > 100
            k = k - 1;
            uniquecheck = 0;
        end
    end       
        
    iter = 0;
    New_Distortion = 0;
    Max_Iter = 100;
    No_Progress = 0.05;
    while true
        distances = euclid_distance(centroids, P);
        [Cluster_Data, class] = min(distances, [], 1);
        iter = iter + 1;
        Old_Distortion = New_Distortion;
        New_Distortion = mean(Cluster_Data);
        if (1-(New_Distortion/Old_Distortion)) < No_Progress
            break;
        elseif iter > Max_Iter
            break;
        end
        
        for i=1:k
            index = find(class == i);
            centroids(:, i) = mean(P(:, index),2);
        end
    end
    display(size(centroids))
    centroid = centroids';
    end

	
	