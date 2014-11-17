classdef grhNode < matlab.mixin.Copyable
    
    properties
        
        ID@uint16;          % node id
        tree;               % pointer to tree the node is part of
        parent;             % parent node
        leftRight@logical;  % relative to parent node 0 leftChild, 1 rightChild
        depth@uint8;        % at which this node lies
        data;               % handle to main data object
        dataIDs@uint16;     % data elements on this leaf / node
        model;              % handle to model applying if leaf
        splitVar@uint8=uint8(0);
        splitVal;
        Lchild = [];        % children
        Rchild = [];        %
        plotHandle@uint8;     % to store graphics handle
        
    end
    
    methods
        
        function obj = grhNode(parent, dataIDs, leftRight, model)
            
            % node constructor function
            
            if nargin
                obj.parent = parent;
                obj.data = parent.data;
                if isa(parent, 'grhTree')
                    % node is trunk of tree
                    obj.tree = parent;
                    obj.ID = obj.tree.const.u16_1;
                    obj.depth = uint8(1);
                    obj.dataIDs = uint16(1:parent.data.Ndata);
                else
                    % node is a sub-node
                    obj.dataIDs = dataIDs;
                    obj.tree = parent.tree;
                    obj.depth = parent.depth + 1;
                    % relation to parent binary split
                    obj.leftRight = leftRight;
                    % get an unused ID from parent tree
                    obj.ID = obj.tree.nextNodeID;
                    while sum(obj.ID == [obj.tree.nodes.ID])
                        obj.ID = obj.ID + uint16(1);
                    end
                    % and update provisional reference for next one
                    obj.tree.nextNodeID = mod(obj.ID + obj.tree.const.u16_1, 65000) + 1;
                    % add self to tree node list
                    obj.tree.nodes(end+1) = obj;                    
                    % remove parent from tree leaves list
%                     obj.tree.leaves = obj.tree.leaves(obj.tree.leaves~=obj.parent);
                    obj.tree.leaves([obj.tree.leaves.ID]==obj.parent.ID) = [];
                    % add self ID to tree leaves list
                    obj.tree.leaves(end+1) = obj;
                    % check and update tree overall depth
                    if obj.depth > obj.tree.total_depth
                        obj.tree.total_depth = obj.tree.total_depth + 1;
                    end
                end
                if nargin == 4
                    obj.model = model;
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
            % set these temporarily as IDs to refer to already copied nodes
            cpObj.parent = cpObj.parent.ID;
            if ~isempty(cpObj.Lchild)
                cpObj.Lchild = cpObj.Lchild.ID;
                cpObj.Rchild = cpObj.Rchild.ID;
            end
        end
    end
    
end
            