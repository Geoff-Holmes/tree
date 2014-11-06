function obj = feedDataForward(obj)

% after change of node splitting rule update data to leaves

fprintf('\nFeed forward from node %d', obj.ID)

% split the data
leftData  = obj.data(obj.data(:,obj.splitVar) <= obj.splitVal, :);
rightData = obj.data(obj.data(:,obj.splitVar) >  obj.splitVal, :);

% where one child becomes empty need to turn parent into leaf absorbing
% other child

if isempty(leftData)
   fprintf('\nLeft data empty at node %d\n', obj.ID)
   % remove empty descendents
   obj.Lchild.removeNode;
   flagLeft = 1;
else
    flagLeft = 0;
    % update child data
    obj.Lchild.data = leftData;
    if ~isempty(obj.Lchild.splitVal)
        obj.Lchild.feedDataForward;
    end
end
if isempty(rightData)
    fprintf('\nRight data empty at node %d\n', obj.ID)
    % remove empty descendants
    obj.Rchild.removeNode;
    flagRight = 1;
else
    flagRight = 0;
    % update child data
    obj.Rchild.data = rightData;
    if ~isempty(obj.Rchild.splitVal)
        obj.Rchild.feedDataForward;
    end
end

assert(~(flagLeft && flagRight))

% set appropriate grandparent to become parent of child!
% and vice versa
if flagLeft
    obj.Rchild.parent = obj.parent;
    obj.Rchild.adjustDepth;
    if obj.leftRight
        obj.parent.Rchild = obj.Rchild;
        obj.Rchild.leftRight = 1;
    else
        obj.parent.Lchild = obj.Rchild;
        obj.Rchild.leftRight = 0;
    end
else
    if flagRight
        obj.Lchild.parent = obj.parent;
        obj.Lchild.adjustDepth;
        if obj.leftRight
            obj.parent.Rchild = obj.Lchild;
            obj.Lchild.leftRight = 1;
        else
            obj.parent.Lchild = obj.Lchild;
            obj.Lchild.leftRight = 0;
        end
    end
end

% in either case remove this node from node list and delete
if flagRight || flagLeft
    obj.tree.nodes = obj.tree.nodes([obj.tree.nodes.ID] ~= obj.ID);
    fprintf('\nDeleting node %d', obj.ID)
    delete(obj)
end
    
end

