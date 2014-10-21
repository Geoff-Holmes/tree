classdef grhTree < grhNode
    
    properties
        
        input_dim;          % dimension of datapoint inputs
        Ndata;              % total number of datapoints
        data_range;         % extent of data space
        total_depth = 1;    % depth of tree
        
        % from grhNode the following fields are inherited
%         tree;           % pointer to tree the node is part of
%         depth;          % at which this node lies
%         data;           % data elements on this leaf / node
%         model;          % handle to model applying if leaf
%         splitVar;
%         splitVal;
%         Lchild = [];    % pointers to children
%         Rchild = [];    %
        
    end
    
    methods
        
        function obj = grhTree(data1, data2)
            
            % initial contructor of tree
            if nargin > 0
                if isstruct(data1)
                    data = [data1.x data1.y];
                    x_dim = size(data1.x, 2);
                else
                    if nargin == 2 
                        data = [data1 data2];
                       x_dim = size(data, 2);
                    else
                        % assume final colunn is output
                        data = data1;
                       x_dim = size(data, 2) - 1;
                    end
                end
            end
            
            % dummy parent for superclass constructor call
            parent = struct('tree', struct('depth', 0), 'depth', 0);
            % call superclass (grhNode) constructor
            obj = obj@grhNode(parent, data);
            % set other field values
            obj.input_dim = x_dim;
            obj.Ndata = size(obj.data, 1);
            obj.data_range = [min(obj.data); max(obj.data);];
            % now set self as tree ! seems to work !
            obj.tree = obj;
            obj.parent = 'self';            
        end
    end 
end
    
    
    