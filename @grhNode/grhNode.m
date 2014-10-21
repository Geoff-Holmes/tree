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
            
            if nargin > 1
                obj.tree = parent.tree;
                obj.depth = parent.depth + 1;
                obj.members = members;
                % check and update tree overall depth
                if obj.depth > obj.tree.depth
                    obj.tree.depth = obj.tree.depth + 1;
                end
            else
                % this is the main trunk
                obj.tree = parent;
                obj.depth = 1;
                obj.members = parent.xdata;
            end
            
        end
    end
end
            