function obj = randomGrow(obj)

% random grow operation see gramacy_bayesian_2008 p1124

randLeafInds = randperm(length(obj.leaves));
flag = 0;
counter = 0;
while ~flag && counter < length(randLeafInds)
    % choose randomly from all leaves
    counter = counter + 1;
    leaf = obj.nodes([obj.nodes.ID] == obj.leaves(randLeafInds(counter)));
    % discard leaf if only one datapoint
    flag = size(leaf.data, 1) - 1;
end
if ~flag, fprintf('\nData already fully split.\n'), return, end

% choose randomly from all dimensions
dim = randi(obj.input_dim);
% choose randomly from all possible split point on this leaf / dim
% and grow by splitting at that point
[~, midpoints] = leaf.dataSortByDim(dim);
splitPoint     = midpoints(randi(length(midpoints)));
leaf.splitNode(dim, splitPoint);

fprintf('\nGrowing from node %d, new leaves %d - %d\n', leaf.ID, leaf.Lchild.ID, leaf.Rchild.ID)

% model management to be added