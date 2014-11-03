function obj = randomPrune(obj)

% random prune operation see gramacy_bayesian_2008 p1124

% choose randomly from all parents of leaves
compLeaf = obj.nodes(obj.leaves(randi(length(obj.leaves)))).parent;

if isa(compLeaf, 'grhTree')
    fprintf('\nNo branches to prune.')
    return
end

% reassemble data from children onto this node
compLeaf.data = vertcat(compLeaf.Rchild.data, compLeaf.Lchild.data);

% get IDs of leaves being pruned
pruneIDs = [compLeaf.Rchild.ID compLeaf.Lchild.ID];
% add newly combined leaf to leaf list and removed pruned leaves
obj.leaves = [obj.leaves compLeaf.ID];
obj.leaves = setdiff(obj.leaves, pruneIDs);

% remove pruned leaves from node list
obj.nodes = obj.nodes([obj.nodes.ID] ~= pruneIDs(1));
obj.nodes = obj.nodes([obj.nodes.ID] ~= pruneIDs(2));
% and delete
delete(compLeaf.Rchild);
delete(compLeaf.Lchild);

% empty the child links etc
compLeaf.Rchild   = [];
compLeaf.Lchild   = [];
compLeaf.splitVar = [];
compLeaf.splitVal = [];

% model management to be added