function obj = randomPrune(obj)

% random prune operation see gramacy_bayesian_2008 p1124

% check for no branches
if obj.total_depth == 1
    % fprintf('\nNo branches to prune.')
    return
end    

% choose randomly from all parents of pairs of leaves
randLeafInds = randperm(length(obj.leaves));

flag = 1;
counter = 0;
while flag && counter < length(randLeafInds)
    counter = counter + 1;
    % parent of next leaf
    compLeaf = obj.leaves(randLeafInds(counter)).parent;
%     % fprintf('\nCandidate for pruning : parent of node %d', obj.leaves(randLeafInds(counter)))
    % discard if both children are not leaves
%     flag = numel(compLeaf.Lchild.splitVar) + numel(compLeaf.Rchild.splitVar);
    flag = ~(isempty(compLeaf.Lchild.splitVar) && isempty(compLeaf.Rchild.splitVar));
end

% fprintf('\nRemoving split at node %d : leaves %d - %d\n', compLeaf.ID, compLeaf.Lchild.ID, compLeaf.Rchild.ID)

% reassemble data from children onto this node
compLeaf.dataIDs = [compLeaf.Rchild.dataIDs, compLeaf.Lchild.dataIDs];
% form composite model from the child models
compLeaf.model = (compLeaf.Rchild.model + compLeaf.Lchild.model)/2;

% add newly combined leaf to leaf list
obj.leaves = [obj.leaves compLeaf];

% remove pruned leaves from node and leaf lists
obj.nodes([obj.nodes.ID] == compLeaf.Lchild.ID | [obj.nodes.ID] == compLeaf.Rchild.ID) = [];
obj.leaves([obj.leaves.ID] == compLeaf.Rchild.ID | [obj.leaves.ID] == compLeaf.Lchild.ID) = [];

% and delete
delete(compLeaf.Rchild);
delete(compLeaf.Lchild);

% empty the child links etc
compLeaf.Rchild   = [];
compLeaf.Lchild   = [];
compLeaf.splitVar = uint8([]);
compLeaf.splitVal = [];

% update tree depth
obj.total_depth = max([obj.leaves.depth]);
