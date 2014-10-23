function thisNode = getNode(obj, testpoint)

% find the node / leaf to which a testpoint belongs

thisNode = obj.nodes(1);

% move up the tree along nodes until a leaf is reached
while ~isempty(thisNode.Rchild)
    
    % choose the correct branch to follow
    if testpoint(thisNode.splitVar) > thisNode.splitVal
        thisNode = thisNode.Rchild;
    else
        thisNode = thisNode.Lchild;
    end
    
end