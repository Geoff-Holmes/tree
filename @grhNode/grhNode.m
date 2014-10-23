classdef grhNode < handle
    
    properties
        
        ID;             % node id
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
            
            if nargin
                obj.parent = parent;
                if isa(parent, 'grhTree')
                    % node is trunk of tree
                    obj.tree = parent;
                    obj.ID = 1;
                    obj.depth = 1;
                    obj.data = parent.data;
                else
                    % node is a sub-node
                    obj.data = data;
                    obj.tree = parent.tree;
                    obj.depth = parent.depth + 1;
                    % relation to parent binary split
                    obj.leftRight = leftRight;
                    % get next ID from parent tree
                    obj.ID = length(obj.tree.nodes) + 1;
                    % add self to parent tree node list
                    obj.tree.nodes(end+1) = obj;                    
                    % check and update tree overall depth
                    if obj.depth > obj.tree.total_depth
                        obj.tree.total_depth = obj.tree.total_depth + 1;
                    end
                end
            else
                assert(1==0); % throw error to test for ending up here
            end
            
        end
    end
end
            