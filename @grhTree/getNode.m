function thisNode = getNode(obj, testpoint)

% find the node / leaf to which a testpoint belongs

thisNode = obj.nodes(1);

while ~isempty(thisNode.Rchild)
    
    if testpoint(thisNode.splitVar) > thisNode.splitVal
        thisNode = thisNode.Rchild;
    else
        thisNode = thisNode.Lchild;
    end
    
end