function inputData = getInputs(obj, inds, dim)

% get data by dimension and indicies

if nargin < 3
    dim = 1:obj.input_dim;
end
if nargin < 2
    inds = 1:Ndata;
end
    
inputData = obj.data(inds, dim);