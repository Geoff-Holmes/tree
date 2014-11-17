function obj = randomGrow(obj)

% random grow operation see gramacy_bayesian_2008 p1124

leaf = obj.leaves(randi(length(obj.leaves)));
% randLeafInds = randperm(length(obj.leaves));
% flag = 0;
% counter = 0;
% while ~flag && counter < length(randLeafInds)
    % choose randomly from all leaves
%     counter = counter + 1;
%     leaf = obj.leaves(randLeafInds(counter));
    % discard leaf if only one datapoint
    flag = numel(leaf.dataIDs) - 1 && rand <= obj.prior.a * double(leaf.depth) ^ -obj.prior.b;
% end
if ~flag
    % fprintf('\nNot splitting\n')
    return
end

midpoints = [];
% choose randomly from all dimensions with at least one midpoint
inds = randperm(obj.data.input_dim);
counter = 0;
while isempty(midpoints)
    counter = counter + 1;
    dim = inds(counter);
    % midpoints  = leaf.data.getSplitPoints(dim, leaf.dataIDs); % data method
    midpoints  = leaf.getSplitPoints(dim);                      % node method
end
% choose randomly from all possible split point on this leaf / dim
splitPoint = midpoints(randi(length(midpoints)));
% and grow by splitting at that point
leaf.splitNode(dim, splitPoint);

% fprintf('\nGrowing from node %d, new leaves %d - %d\n', leaf.ID, leaf.Lchild.ID, leaf.Rchild.ID)

% model management to be added