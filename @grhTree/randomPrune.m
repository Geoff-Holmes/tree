function obj = randomPrune(obj)

% random prune operation see gramacy_bayesian_2008 p1124

% get all parent nodes
parentIDs = setdiff([obj.nodes.ID], obj.leaves);

% choose randomly from all parents
compLeaf = obj.nodes(parentIDs(randi(length(parentIDs))));

% reassemble data from children onto this node
compLeaf.data = vertcat(compLeaf.Rchild.data, compLeaf.Lchild.data);

% add newly combined leaf to leaf list and removed pruned leaves
obj.leaves = [obj.leaves compLeaf.ID];
obj.leaves = setdiff(obj.leaves, [compLeaf.Rchild.ID complLeaf.Lchild.ID]);

% model management to be added