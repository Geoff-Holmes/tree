function obj = feedDataForward(obj)

% after change of node splitting rule update data to leaves

% split the data
leftData  = obj.data(obj.data(:,obj.splitVar) <= obj.splitVal, :);
rightData = obj.data(obj.data(:,obj.splitVar) >  obj.splitVal, :);

% where one child becomes empty need to turn parent into leaf absorbing
% other child

if isempty(leftData)
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

flagLeft
flagRight

% set appropriate grandparent to become parent of child!
if flagLeft
    if obj.leftRight
        obj.parent.Rchild = obj.Rchild;
    else
        obj.parent.Lchild = obj.Rchild;
        
    end
else
    if flagRight
        if obj.leftRight
            obj.parent.Rchild = obj.Lchild;
        else
            obj.parent.Lchild = obj.Lchild;
            
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

