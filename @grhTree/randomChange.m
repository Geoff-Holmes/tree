function obj = randomChange(obj)

% random change operation see gramacy_bayesian_2008 p1125


% check for no branches
if numel(obj.nodes) == 1
    fprintf('\nNo branches to change.')
    return
end    

% choose an internal node
parentIDs = setdiff([obj.nodes.ID], obj.leaves);
parent = obj.nodes([obj.nodes.ID] == parentIDs(randi(length(parentIDs))));

fprintf('\nChanging split at node %d\n', parent.ID)

% choose randomly from all dimensions
dim = randi(obj.input_dim);
% choose randomly from all possible split point on this leaf / dim
% and grow by splitting at that point
[~, midpoints] = parent.dataSortByDim(dim);
splitPoint     = midpoints(randi(length(midpoints)));

% update fields
parent.splitVar = dim;
parent.splitVal = splitPoint;

% update data to leaves
parent.feedDataForward;

