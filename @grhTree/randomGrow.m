function obj = randomGrow(obj)

% random grow operation see gramacy_bayesian_2008 p1124
% grow prob depends on depth of leaf

% get exact and approx growth probs for each leaf
growProbs  = obj.prior.a * double([obj.leaves.depth]) .^ -obj.prior.b;
% get approximate growth probs
growProbs  = round(10 * growProbs / min(growProbs));
% prepare for sampling
F = 1:max(growProbs);
I = meshgrid(growProbs, F);
[X, Y] = meshgrid(1:numel(obj.leaves), F);
randLeafInds = X(Y<=I);

% randLeafInds = randperm(length(obj.leaves));
flag = 0;
% counter = 0;
while ~flag %&& counter < length(randLeafInds)
    p = cumsum(1:numel(randLeafInds));
    p = p / p(end);
    % choose randomly from all leaves
%     counter = counter + 1;
    ind = find(rand <= p, 1, 'first');
    leaf = obj.leaves(randLeafInds(ind));
    % discard leaf if only one datapoint
    if numel(leaf.dataIDs) == 1
        randLeafInds = randLeafInds(randLeafInds ~= randLeafInds(ind));
    else
        flag = 1;
    end
end
if ~flag
    % fprintf('\nData already fully split.\n')
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
