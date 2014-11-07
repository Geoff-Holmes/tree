function obj = testDataPlacement(obj, mode)

% test for datapoints correctly placed
if nargin < 2
    mode = 'one';
end

if strcmp(mode, 'many')
    leaves = obj.leaves;
else
    leaves = obj.leaves(randi(length(obj.leaves)));
end

for leaf = leaves
    
    if strcmp(mode, 'all')
        for j = 1:size(leaf.data, 1)
            try
                assert(obj.getNode(leaf.data(j, :)).ID==leaf.ID);
            catch
                obj.health.misplacedData = 1;
                fprintf('\nData misplaced on leaf %d', leaf.ID)
            end
        end
    else
        dataID = randi(size(leaf.data, 1));
        try
            assert(obj.getNode(leaf.data(dataID, :)).ID==leaf.ID);
        catch
            obj.health.misplacedData = 1;
            fprintf('\nData misplaced on leaf %d', leaf.ID)
        end
    end
end