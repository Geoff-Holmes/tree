classdef grhTree < grhNode
    
    properties
        
%         data;        % data inputs
        input_dim;   % dimension of datapoint inputs
        Ndata;       % total number of datapoints
        data_range;  % extent of data space
%         depth = 1;   % depth of tree
%         splitVar;    %
%         splitVal     %
%         Lchild;      %
%         Rchild;
        
    end
    
    methods
        
        function obj = grhTree(data1, data2)
            
            % initial contructor of tree
            if nargin > 0
                if isstruct(data1)
                    data = [data1.x data1.y];
                    input_dim = size(data1.x, 2);
                else
                    if nargin == 2 
                        data = [data1 data2];
                        input_dim = size(data, 2);
                    else
                        % assume final colunn is output
                        data = data1;
                        input_dim = size(data, 2) - 1;
                    end
                end
            end
            
            parent = struct('tree', struct('depth', 0), 'depth', 0);
            obj = obj@grhNode(parent, data);
            obj.input_dim = input_dim;
            obj.Ndata = size(obj.data, 1);
            obj.data_range = [min(obj.data); max(obj.data);];
%             obj.trunk  = grhNode(obj);
            
        end
    end 
end
    
    
    