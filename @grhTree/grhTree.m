classdef grhTree < matlab.mixin.Copyable
    
    properties
        
        data;               % data
        input_dim;          % dimension of datapoint inputs
        Ndata;              % total number of datapoints
        data_range;         % extent of data space
        total_depth = 1;    % depth of tree
        nodes;              % list of pointers to all nodes incl leaves
        leaves;             % list of IDs of all leaves
        plotHandle;         % figure handle for plot
        health = struct();  % consistency check storage
        
    end
    
    methods
        
        function obj = grhTree(data1, data2)
            
            % initial contructor of tree
            
            % parse input data
            if nargin > 0
                if numel(data1) == 2
                    assert(size(data2, 2) == sum(data1))
                    obj.input_dim  = data1(1);
                    obj.data_range = data2;
                else
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
            end
            
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
            % Make a deep copy of the handle objects
            cpObj.nodes = copy(obj.nodes);
            cpObj.leaves = copy(obj.leaves);
        end
    end
end
    
    
    