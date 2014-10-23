classdef grhTree < handle
    
    properties
        
        data;               % data
        input_dim;          % dimension of datapoint inputs
        Ndata;              % total number of datapoints
        data_range;         % extent of data space
        total_depth = 1;    % depth of tree
        nodes;              % list of pointers to all nodes
        
    end
    
    methods
        
        function obj = grhTree(data1, data2)
            
            % initial contructor of tree
            
            % parse input data
            if nargin > 0
                if isstruct(data1)
                    obj.data = [data1.x data1.y];
                    obj.input_dim = size(data1.x, 2);
                else
                    if nargin == 2 
                        obj.data = [data1 data2];
                        obj.input_dim = size(data1, 2);
                    else
                        % assume final colunn is output
                        obj.data = data1;
                        obj.input_dim = size(data1, 2) - 1;
                    end
                end
                obj.Ndata = size(obj.data, 1);
                obj.data_range = [min(obj.data); max(obj.data);];
            end
            
            % initialise node list
            obj.nodes = grhNode(obj);

        end
    end 
end
    
    
    