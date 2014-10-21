classdef grhNode < handle
    
    properties
        
        tree;           % pointer to tree the node is part of
        parent;         % parent node
        leftRight;      % relative to parent node 0 left, 1 right
        depth;          % at which this node lies
        data;           % data elements on this leaf / node
        model;          % handle to model applying if leaf
        splitVar;
        splitVal;
        Lchild = [];    % pointers to children
        Rchild = [];    %
        
    end
    
    methods
        
        function obj = grhNode(parent, data, leftRight)
            
            if nargin > 1
                obj.parent = parent;
                obj.tree = parent.tree;
                obj.depth = parent.depth + 1;
                obj.data = data;
                % check and update tree overall depth
                if obj.depth > 1 && obj.depth > obj.tree.total_depth
                    obj.tree.total_depth = obj.tree.total_depth + 1;
                end
                if nargin == 3
                    obj.leftRight = leftRight;
                end
            else
                % this is the main trunk
%                 obj.tree = parent;
%                 obj.depth = 1;
%                 obj.data = parent.data;
                assert(1==0); % throw error to test for ending up here
            end
            
        end
    end
end
            