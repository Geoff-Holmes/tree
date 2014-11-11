classdef grhTree < matlab.mixin.Copyable
    
    properties
        
        data;               % data
        total_depth = 1;    % depth of tree
        nodes;              % list of handles of all nodes incl leaves
        leaves;             % list of handles of all leaves
        plotHandle;         % figure handle for plot
        health = struct();  % consistency check storage
        nextNodeID@uint16 = uint16(2);  % reference for node labelling            
        
    end
    
    methods
        
        function obj = grhTree(data)
            
            % initial contructor of tree
            % handle to data object
            obj.data = data;
            % initialise node and lieaf list
            newNode    = grhNode(obj);
            obj.nodes  = newNode;
            obj.leaves = newNode;
        end
    end
    
    methods(Access = protected)
        % Override copyElement method:
        function cpObj = copyElement(obj)
            % Make a shallow copy of all properties
            cpObj = copyElement@matlab.mixin.Copyable(obj);
            % Make a deep copy of the node handle objects
            cpObj.nodes = copy(obj.nodes);
            % make real temporary ID references
            for node = cpObj.nodes
                node.tree  = obj;
                if node.parent
                    node.parent = cpObj.nodes([cpObj.nodes.ID]==node.parent);
                else
                    node.parent = obj;
                end
                if numel(node.Lchild)
                    node.Lchild = cpObj.nodes([cpObj.nodes.ID]==node.Lchild);
                    node.Rchild = cpObj.nodes([cpObj.nodes.ID]==node.Rchild);
                end
            end
            % link leaf list to copied node list
            [~,leafIDs] = intersect(obj.nodes, obj.leaves);
            cpObj.leaves = cpObj.nodes(leafIDs);
            % remove any plot handles
            cpObj.plotHandle = [];
        end
    end
end
    
    
    