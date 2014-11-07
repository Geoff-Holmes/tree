function obj = randomPrune(obj)

% random prune operation see gramacy_bayesian_2008 p1124

% check for no branches
if numel(obj.nodes) == 1
    fprintf('\nNo branches to prune.')
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
%     fprintf('\nCandidate for pruning : parent of node %d', obj.leaves(randLeafInds(counter)))
    % discard if both children are not leaves
    flag = numel(compLeaf.Lchild.splitVar) + numel(compLeaf.Rchild.splitVar);
end

fprintf('\nRemoving split at node %d : leaves %d - %d\n', compLeaf.ID, compLeaf.Lchild.ID, compLeaf.Rchild.ID)

% reassemble data from children onto this node
compLeaf.data = vertcat(compLeaf.Rchild.data, compLeaf.Lchild.data);

% add newly combined leaf to leaf list and removed pruned leaves
obj.leaves = [obj.leaves compLeaf];
obj.leaves = setdiff(obj.leaves, [compLeaf.Rchild compLeaf.Lchild]);

% remove pruned leaves from node list
obj.nodes = obj.nodes(obj.nodes ~= compLeaf.Lchild);
obj.nodes = obj.nodes(obj.nodes ~= compLeaf.Rchild);
% and delete
delete(compLeaf.Rchild);
delete(compLeaf.Lchild);

% empty the child links etc
compLeaf.Rchild   = [];
compLeaf.Lchild   = [];
compLeaf.splitVar = [];
compLeaf.splitVal = [];

% update tree depth
obj.total_depth = max([obj.nodes.depth]);

% model management to be added