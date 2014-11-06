function obj = randomSwap(obj)

% random swap or rotate operation see gramacy_bayesian_2008 p1124
% chipman_bayesian_1998 p941

% check for not enough branches
if obj.total_depth < 3
    fprintf('\nTree not deep enough to swap nodes.\n')
    return
end

% choose an internal parent-child pair
% choose an internal child node
childIDs = setdiff([obj.nodes.ID], [1 obj.leaves]);
child = obj.nodes([obj.nodes.ID] == childIDs(randi(length(childIDs))));

if child.splitVar == child.parent.splitVar

    % ROTATE
    % swap splitting rules
    temp.splitVar = child.splitVar;
    temp.splitVal = child.splitVal;
    child.splitVar = child.parent.splitVar;
    child.splitVal = child.parent.splitVal;
    child.parent.splitVar = temp.splitVar;
    child.parent.splitVal = temp.splitVal;
    % swap relationship to parent left to right or v.v.
    child.leftRight = ~child.leftRight;

    % if right child
    if child.leftRight == 0
        fprintf('\nRotating left nodes %d - %d\n', child.ID, child.parent.ID)
        tempChild = child.Rchild;
        child.Rchild = child.Lchild;
        child.Rchild.leftRight = ~child.Lchild.leftRight;
        child.Lchild = child.parent.Lchild;
        child.Lchild.parent = child;
        child.parent.Lchild = child;
    %     child.leftRight = ~child.leftRight % done above
        tempChild.parent = child.parent;
        tempChild.adjustDepth(-1);
        child.parent.Rchild = tempChild;
        child.Lchild.adjustDepth(1);
        % otherwise left child    
    else % child.leftRight = 0
        fprintf('\nRotating right nodes %d - %d\n', child.ID, child.parent.ID)
        tempChild = child.Lchild;
        child.Lchild = child.Rchild;
        child.Lchild.leftRight = ~child.Lchild.leftRight;
        child.Rchild = child.parent.Rchild;
        child.Rchild.parent = child;
        child.parent.Rchild = child;
    %     child.leftRight = ~child.leftRight % done above
        tempChild.parent = child.parent;
        tempChild.adjustDepth(-1);
        child.parent.Lchild = tempChild;
        child.Rchild.adjustDepth(1);
    end

else
    
    % SWAP
   fprintf('\nSwapping nodes %d - %d\n', child.parent.ID, child.ID)
   temp = child.splitVal;
   child.splitVal = child.parent.splitVal;
   child.parent.splitVal = temp;
   child.parent.feedDataForward;
   
end