function showNodeRegion(obj)

% show all inequalities that apply to the region of input space that is
% allocated to this leaf

thisNode = obj;

% work back up the tree to the trunk node
while thisNode.depth > 1
    
    % ascertain relation to parent node
    if thisNode.leftRight, reln = '>'; else reln = '<='; end
    % output the applicable relationship
    fprintf('x%d %s %f\n', thisNode.parent.splitVar, reln, thisNode.parent.splitVal)
    % step back up one level
    thisNode = thisNode.parent;
    
end