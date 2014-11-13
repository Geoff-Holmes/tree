function obj = testAllDataAtLeaves(obj)

% test for data all present at leaves

NleafData = numel([obj.leaves.dataIDs]);

try
    assert(NleafData == obj.data.Ndata)
catch
    obj.health.lostData = 1;
    if NleafData < obj.data.Ndata
        % fprintf('\nData missing from leaves\n')
    else
        % fprintf('\nExtra data at leaves\n')
    end
    
end