function obj = removeNode(obj)

% where data is empty recursively remove nodes to leaves

% decide if obj is parent or leaf
if numel(obj.splitVar)
    % parent so remove children
    obj.Lchild.removeNode;
    obj.Rchild.removeNode;
else
    % leaf so remove from leaf list
    obj.tree.leaves = obj.tree.leaves(obj.tree.leaves~=obj.ID);
end

% in either case remove from node list and delete
obj.tree.nodes = obj.tree.nodes([obj.tree.nodes.ID]~=obj.ID);
fprintf('\nDeleting node %d\n', obj.ID)
delete(obj)