classdef grhTree < handle
    
    properties
        
        data;        % data inputs
        input_dim;   % dimension of datapoint inputs
        data_range;  % extent of data space
        Ndata;       % total number of datapoints
        depth = 1;   % depth of tree
        Lchild;      % as it says
        Rchild;
        
    end
    
    methods
        
        function obj = grhTree(data1, data2)
            
            % initial contructor of tree
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
                        obj.input_dim = size(data1, 2) - 1;
                    end
                end
            end
            
            obj.Ndata = size(obj.data, 1);
            obj.data_range = [min(obj.data); max(obj.data);];
%             obj.trunk  = grhNode(obj);
            
        end
    end 
end
    
    
    