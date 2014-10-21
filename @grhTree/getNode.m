function thisNode = getNode(obj, testpoint)

% find the node / leaf to which a testpoint belongs

thisNode = obj;

while ~isempty(thisNode.splitVar)
    
    if testpoint(thisNode.splitVar) > thisNode.splitVal
        thisNode = obj.Rchild;
    else
        thisNode = obj.Lchild;
    end
    
end