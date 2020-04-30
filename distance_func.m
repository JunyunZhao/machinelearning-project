%Euclidean distance
function dist = distance_func(a, b)
% norm 2 distance
dist = sum((a-b).^2);
end