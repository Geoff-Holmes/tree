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
                    obj.tree = parent.tree;
                    % get next ID from parent tree
                    obj.ID = length(obj.tree.nodes) + 1;
                    % add self to parent tree node list
                    obj.tree.nodes(end+1) = obj;
                    obj.depth = parent.depth + 1;
                    obj.data = data;
                    % check and update tree overall depth
                    if obj.depth > obj.tree.total_depth
                        obj.tree.total_depth = obj.tree.total_depth + 1;
                    end
                end
                if nargin == 3
                    obj.leftRight = leftRight;
                end
            else
                % return empty node
               
                % this is the main trunk
%                 obj.tree = parent;
%                 obj.depth = 1;
%                 obj.data = parent.data;
%                 assert(1==0); % throw error to test for ending up here
            end
            
        end
    end
end
            