function obj = testAllDataAtLeaves(obj)

% test for data all present at leaves

NleafData = sum(vertcat(obj.leaves.dataIDs), 1);

try
    assert(NleafData == obj.data.Ndata)
catch
    obj.health.lostData = 1;
    if NleafData < obj.data.Ndata
        fprintf('\nData missing from leaves\n')
    else
        fprintf('\nExtra data at leaves\n')
    end
    
end