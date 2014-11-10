function obj = testDataAllLengths(obj)

for node = obj.nodes(~ismember(obj.nodes, obj.leaves)) 
    try
        assert(sum(node.dataIDs, 1) == sum(node.Lchild.dataIDs, 1) + sum(node.Rchild.dataIDs, 1));
    catch
        obj.health.allDataLengths = 1;
        fprintf('\nMismatched data between parent %d - children %d, %d\n', node.ID, node.Lchild.ID, node.Rchild.ID);
    end
end

