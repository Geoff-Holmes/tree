function obj = setOutputs(obj, inds, dim, outputs)

% set output data by inds and output dim

if nargin < 3
    dim = 1;
end
    dim = obj.input_dim+dim;

if nargin < 2
    inds = 1:obj.Ndata;
end
    
obj.data(inds, dim) = outputs;