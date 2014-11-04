function obj = adjustDepth(obj, diff)

% recursively adjust depths given parent replaced by grandparent

if nargin < 2
    diff = -1;
end

% set new depth
obj.depth = obj.depth + diff;

% set new depth for any children
if numel(obj.splitVar)
    obj.Lchild.adjustDepth;
    obj.Rchild.adjustDepth;
end