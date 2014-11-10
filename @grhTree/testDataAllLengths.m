function obj = testDataAllLengths(obj)

for node = obj.nodes(~ismember(obj.nodes, obj.leaves)) 
    try
        assert(numel(node.dataIDs) == numel(node.Lchild.dataIDs) + numel(node.Rchild.dataIDs));
    catch
        obj.health.allDataLengths = 1;
        fprintf('\nMismatched data between parent %d - children %d, %d\n', node.ID, node.Lchild.ID, node.Rchild.ID);
    end
end

