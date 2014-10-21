function thisNode = getNode(obj, testpoint)

% find the node / leaf to which a testpoint belongs

thisNode = obj;
cc = 0;

while ~isempty(thisNode.Rchild) && cc < 5
    
    cc = cc + 1
    
    thisNode
    
    if testpoint(thisNode.splitVar) > thisNode.splitVal
        thisNode = thisNode.Rchild;
    else
        thisNode = thisNode.Lchild;
    end
    
end