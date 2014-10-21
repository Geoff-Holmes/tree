function showNodeRegion(obj)

thisNode = obj;

while thisNode.depth > 1
    
    if thisNode.leftRight, reln = '>'; else reln = '<='; end
    fprintf('x%d %s %f\n', thisNode.parent.splitVar, reln, thisNode.parent.splitVal)
    thisNode = thisNode.parent;
    
end