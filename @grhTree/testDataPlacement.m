function obj = testDataPlacement(obj, mode)

% test for datapoints correctly placed
if nargin < 2
    mode = 'one';
end

if strcmp(mode, 'many')
    leafID = obj.leaves;
else
    leafID = obj.leaves(randi(length(obj.leaves)));
end

for i = leafID
    leaf = obj.nodes([obj.nodes.ID]==leafID);    
    
    if strcmp(mode, 'all')
        for j = 1:size(leaf.data, 1)
            try
                assert(obj.getNode(leaf.data(j, :)).ID==leafID);
            catch
                obj.health.misplacedData = 1;
                fprintf('\nData misplaced on leaf %d', leafID)
            end
        end
    else
        dataID = randi(size(leaf.data, 1));
        try
            assert(obj.getNode(leaf.data(dataID, :)).ID==leafID);
        catch
            obj.health.misplacedData = 1;
            fprintf('\nData misplaced on leaf %d', leafID)
        end
    end
end