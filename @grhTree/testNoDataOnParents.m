function obj = testNoDataOnParents(obj)

for node = obj.nodes(~ismember(obj.nodes, obj.leaves)) 
    try
        assert(isempty(node.dataIDs));
    catch
        obj.health.dataOnParent = 1;
        fprintf('\nDataIDs on parent %d\n', node.ID);
    end
end

