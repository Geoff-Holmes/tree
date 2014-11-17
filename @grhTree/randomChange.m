function [obj, parent, dim, splitPoint] = randomChange(obj)

% random change operation see gramacy_bayesian_2008 p1125

% check for no branches
if obj.total_depth == 1
    % fprintf('\nNo branches to change.')
    return
end    

% choose an internal node
% parents = setdiff(obj.nodes, obj.leaves);
parents = obj.nodes(logical([obj.nodes.splitVar]));
parent = parents(randi(length(parents)));

% fprintf('\nChanging split at node %d\n', parent.ID)

% choose randomly from all dimensions ensuring a splitpoint
midpoints = [];
dims = uint8(randperm(obj.data.input_dim));
cc = 0;
while isempty(midpoints)
    cc = cc+1;
    dim = dims(cc);
    [midpoints, dataIDs]  = parent.getSplitPoints(dim); % node method
end
splitPoint = midpoints(randi(length(midpoints)));

% update fields
parent.splitVar = dim;
parent.splitVal = splitPoint;

% update data to leaves
parent.feedDataForward(dataIDs);

% update total depth in case change has occurred
obj.total_depth = max([obj.leaves.depth]);