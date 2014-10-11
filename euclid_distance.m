function [distance] = euclid_distance(V1, V2) 
     [m, n] = size(V1);
     [p, q] = size(V2);
     r1 = kron(V1,ones(1,q));
     r2 = repmat(V2, [1, n]);
     d = sum((r1 - r2).^2, 1);
     distance = reshape(d.',q,n).'; 
 end