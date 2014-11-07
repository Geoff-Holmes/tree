classdef grhNode < matlab.mixin.Copyable
    
    properties
        
        ID;             % node id
        tree;           % pointer to tree the node is part of
        parent;         % parent node
        leftRight;      % relative to parent node 0 leftChild, 1 rightChild
        depth;          % at which this node lies
        data;           % data elements on this leaf / node
        model;          % handle to model applying if leaf
        splitVar;
        splitVal;
        Lchild = [];    % pointers to children
        Rchild = [];    %
       
        plotHandle;     % to store graphics handle
        
    end
    
    methods
        
        function obj = grhNode(parent, data, leftRight)
            
            % node constructor function
            
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
                    % get an unused ID from parent tree
                    obj.ID = max([obj.tree.nodes.ID]) + 1;
                    % add self to tree node list
                    obj.tree.nodes(end+1) = obj;                    
                    % remove parent from tree leaves list
                    obj.tree.leaves = obj.tree.leaves(obj.tree.leaves~=obj.parent);
                    % add self ID to tree leaves list
                    obj.tree.leaves(end+1) = obj;
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
    
    methods(Access = protected)
        % Override copyElement method:
        function cpObj = copyElement(obj)
            % Make a shallow copy of all properties
            cpObj = copyElement@matlab.mixin.Copyable(obj);
            % Make a deep copy of the handle objects
            cpObj.tree = copy(obj.tree);
            cpObj.parent = copy(obj.parent);
            cpObj.Lchild = copy(obj.Lchild);
            cpObj.Rchild = copy(obj.Rchild);
            
        end
    end
    
end
            