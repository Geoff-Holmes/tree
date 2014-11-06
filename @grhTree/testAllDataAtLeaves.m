function obj = testAllDataAtLeaves(obj)

% test for data all present at leaves

leafInds = ismember([obj.nodes.ID], obj.leaves);

NleafData = size(vertcat(obj.nodes(leafInds).data), 1);

try
    assert(NleafData == size(obj.data, 1))
catch
    obj.health.lostData = 1;
    if NleafData < size(obj.data, 1)
        fprintf('\nData missing from leaves\n')
    else
        fprintf('\nExtra data at leaves\n')
    end
    
end