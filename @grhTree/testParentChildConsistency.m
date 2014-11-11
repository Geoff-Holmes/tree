function obj = testParentChildConsistency(obj)

% test for consistent parent child record between all nodes

for node = obj.nodes(2:end)
%     fprintf('\nChecking child-parent-child from nodes %d\n', node.ID)
    try
        if node.leftRight
            assert(node == node.parent.Rchild)
        else
            assert(node == node.parent.Lchild)
        end
    catch
        if node.leftRight == 1, str='right'; else str='left'; end
        try
            cL = node.parent.Lchild.ID;
        catch
            cL = 0;
        end
        try
            cR = node.parent.Rchild.ID;
        catch
            cR= 0;
        end
        
        fprintf('\nrelation error: %s child %d - parent %d - children %d, %d\n', str, node.ID, node.parent.ID, cL, cR)
        
        obj.health.relationError = 1;
    end
end

