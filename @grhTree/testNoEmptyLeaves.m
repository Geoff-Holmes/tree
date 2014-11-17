function obj = testNoEmptyLeaves(obj)

% test for no leaves empty of data
for leaf = obj.leaves
    try
        assert(~isempty(leaf.dataIDs))
    catch
        obj.health.emptyLeaf = 1;
        % fprintf('\nNo data at leaf %d\n', leaf.ID)
    end
end