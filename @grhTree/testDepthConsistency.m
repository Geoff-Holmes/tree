function obj = testDepthConsistency(obj)

% test all nodes for depth consistency

for i = 2:length(obj.nodes)
    try
        assert(obj.nodes(i).depth == obj.nodes(i).parent.depth+1)
    catch
        % fprintf('\nDepth consistency failed for nodes %d - %d\n', obj.nodes(i).ID, obj.nodes.(i).parent.ID)
        obj.health.depthFail = 1;
    end
end

temp = max([obj.nodes.depth]);
try
    assert(obj.total_depth == temp)
catch
    % fprintf('\nTotal depth error : %d should be %d\n', obj.total_depth, temp)
    obj.health.depthFail = 1;
end