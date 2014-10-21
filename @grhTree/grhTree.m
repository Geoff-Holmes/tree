classdef grhTree
    
    properties
        
        xdata = []; % data inputs
        ydata = []; % data outputs
        xdim        % dimension of datapoint inputs
        xrange     % extent of input space
        Nxdata      % total number of datapoints
        depth = 1;  % depth of tree
        nodes       % as it says
        
    end
    
    methods
        
        function obj = grhTree(data1, data2)
            
            % initial contructor of tree
            if nargin > 0
                if isstruct(data1)
                    obj.xdata = data1.x;
                    obj.ydata = data1.y;
                else
                    if nargin == 2 
                        obj.xdata = data1;
                        obj.ydata = data2;
                    else
                        obj.xdata = data1(:, 1:end-1);
                        obj.ydata = data1(:, end);
                    end
                end
            end
            
            obj.xdim   = size(obj.xdata, 2);
            obj.Nxdata = size(obj.xdata, 1);
            obj.xrange = [min(obj.xdata') max(obj.xdata)']';
            obj.nodes  = node(1:obj.Nxdata);
            
        end
    end 
end
    
    
    