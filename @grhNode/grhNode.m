classdef grhNode < handle
    
    properties
        
        tree;           % pointer to tree the node is part of
        depth;          % at which this node lies
        members;        % data elements on this leaf / node
        model;          % handle to model applying if leaf
        splitVar;
        splitVal;
        Lchild = [];    % pointers to children
        Rchild = [];    %
        
    end
    
    methods
        
        function obj = grhNode(parent, members)
            
            obj.depth = parent.depth + 1;
            obj.members = members;
            
        end
    end
end
            