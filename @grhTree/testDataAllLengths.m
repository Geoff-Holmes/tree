function obj = testDataAllLengths(obj)

for node = obj.nodes(~ismember(obj.nodes, obj.leaves)) 
    try
        assert(size(node.data, 1) == size(node.Lchild.data, 1) + size(node.Rchild.data, 1));
    catch
        obj.health.allDataLengths = 1;
        fprintf('\nMismatched data between parend %d - children %d, %d\n', node.ID, node.Lchild.ID, node.Rchild.ID);
    end
end

