function outputData = getOutputs(obj, inds, dim)

% get data by dimension and indicies

outputDims = obj.input_dim+1:obj.input_dim+obj.output_dim;
if nargin < 3
    dim = outputDims;
else
    dim = outputDims(dim);
end

if nargin < 2
    inds = 1:Ndata;
end
    
outputData = obj.data(inds, dim);