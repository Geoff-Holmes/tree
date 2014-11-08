classdef grhData < handle
    
    properties
        data;
        Ndata;
        input_dim;
        output_dim = 1;
        range;
    end
    
    methods
        function obj = grhData(data1, data2)
            % parse input data
            if nargin > 0
                % no data - dimensions and range specified
                if numel(data1) == 2
                    assert(size(data2, 2) == sum(data1))
                    obj.input_dim  = data1(1);
                    obj.range = data2;
                else
                    if isstruct(data1)
                        obj.data = [data1.x data1.y];
                        obj.input_dim  = size(data1.x, 2);
                        obj.output_dim = size(data1.y, 2);
                        
                    else
                        if nargin == 2 
                            obj.data = [data1 data2];
                            obj.input_dim  = size(data1, 2);
                            obj.output_dim = size(data2, 2);
                        else
                            % assume final colunn is output
                            obj.data = data1;
                            obj.input_dim = size(data1, 2) - 1;
                        end
                    end
                    obj.Ndata = size(obj.data, 1);
                    obj.range = [min(obj.data); max(obj.data);];
                end
            end
        end
    end
end