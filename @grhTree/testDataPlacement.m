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
%     dataIDs = leaf.dataIDs';
    if strcmp(mode, 'all')
        for j = leaf.dataIDs
            try
                assert(obj.getNode(leaf.data.getInputs(j)).ID==leaf.ID);
            catch
                obj.health.misplacedData = 1;
%                 fprintf('\nData misplaced on leaf %d', leaf.ID)
            end
        end
    else
        dataID = obj.dataIDs(randi(length(obj.dataIDs)));
        try
            assert(obj.getNode(leaf.data.getInputs(dataID)).ID==leaf.ID);
        catch
            obj.health.misplacedData = 1;
%             fprintf('\nData misplaced on leaf %d', leaf.ID)
        end
    end
end