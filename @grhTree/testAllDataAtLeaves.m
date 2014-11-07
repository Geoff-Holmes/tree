function obj = testAllDataAtLeaves(obj)

% test for data all present at leaves

NleafData = size(vertcat(obj.leaves.data), 1);

try
    assert(NleafData == obj.Ndata)
catch
    obj.health.lostData = 1;
    if NleafData < obj.Ndata
        fprintf('\nData missing from leaves\n')
    else
        fprintf('\nExtra data at leaves\n')
    end
    
end