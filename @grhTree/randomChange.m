function obj = randomChange(obj)

% random change operation see gramacy_bayesian_2008 p1125

% check for no branches
if numel(obj.nodes) == 1
    fprintf('\nNo branches to change.')
    return
end    

% choose an internal node
parents = setdiff(obj.nodes, obj.leaves);
parent = parents(randi(length(parents)));

fprintf('\nChanging split at node %d\n', parent.ID)

% choose randomly from all dimensions
dim = randi(obj.data.input_dim, 'uint8');
% choose randomly from all possible split point on this leaf / dim
% and grow by splitting at that point
% midpoints  = parent.data.getSplitPoints(dim, parent.dataIDs); % data method
[midpoints, dataIDs]  = parent.getSplitPoints(dim); % node method
splitPoint = midpoints(randi(length(midpoints)));

% update fields
parent.splitVar = dim;
parent.splitVal = splitPoint;

% update data to leaves
parent.feedDataForward(dataIDs);

% update total depth in case change has occurred
obj.total_depth = max([obj.nodes.depth]);