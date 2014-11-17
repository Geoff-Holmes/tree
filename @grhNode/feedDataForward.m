function obj = feedDataForward(obj, dataIDs)

% after change of node splitting rule update data to leaves

% fprintf('\nFeed forward from node %d', obj.ID)

% % split the data
% leftData  = obj.data(obj.data(:,obj.splitVar) <= obj.splitVal, :);
% rightData = obj.data(obj.data(:,obj.splitVar) >  obj.splitVal, :);

% get this nodes data on chosen variable / dimension
data = obj.data.getInputs(dataIDs, obj.splitVar);
% split the data
leftDataIDs  = dataIDs(data <= obj.splitVal);
rightDataIDs = dataIDs(data >  obj.splitVal);

% where one child becomes empty need to turn parent into leaf absorbing
% other child

if isempty(leftDataIDs)
%    fprintf('\nLeft data empty at node %d\n', obj.ID)
   % remove empty descendents
   obj.Lchild.removeNode;
   flagLeft = 1;
else
    flagLeft = 0;
    if ~isempty(obj.Lchild.splitVal)
        % not yet at leaf
        obj.Lchild.feedDataForward(leftDataIDs);
    else
        % update child data onleaf
        obj.Lchild.dataIDs = leftDataIDs;
    end
end
if isempty(rightDataIDs)
%     fprintf('\nRight data empty at node %d\n', obj.ID)
    % remove empty descendants
    obj.Rchild.removeNode;
    flagRight = 1;
else
    flagRight = 0;
    % update child data
%     obj.Rchild.dataIDs = rightDataIDs;
    if ~isempty(obj.Rchild.splitVal)
        % not yet at leaf
        obj.Rchild.feedDataForward(rightDataIDs);
    else
        % update child data onleaf
        obj.Rchild.dataIDs = rightDataIDs;
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
        obj.Rchild.leftRight = true;
    else
        obj.parent.Lchild = obj.Rchild;
        obj.Rchild.leftRight = false;
    end
else
    if flagRight
        obj.Lchild.parent = obj.parent;
        obj.Lchild.adjustDepth;
        if obj.leftRight
            obj.parent.Rchild = obj.Lchild;
            obj.Lchild.leftRight = true;
        else
            obj.parent.Lchild = obj.Lchild;
            obj.Lchild.leftRight = false;
        end
    end
end

% in either case remove this node from node list and delete
if flagRight || flagLeft
    obj.tree.nodes = obj.tree.nodes([obj.tree.nodes.ID] ~= obj.ID);
%     fprintf('\nDeleting node %d', obj.ID)
    delete(obj)
end
    
end

