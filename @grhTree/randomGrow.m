function obj = randomGrow(obj)

% random grow operation see gramacy_bayesian_2008 p1124

flag = 0;
while ~flag
    % choose randomly from all leaves
    leaf = obj.nodes(obj.leaves(randi(length(obj.leaves))));
    flag = size(leaf.data, 1) - 1;
end
% choose randomly from all dimensions
dim = randi(obj.input_dim);
% choose randomly from all possible split point on this leaf / dim
% and grow by splitting at that point
[~, midpoints] = leaf.dataSortByDim(dim);
splitPoint     = midpoints(randi(length(midpoints)));
leaf.splitNode(dim, splitPoint);

% model management to be added