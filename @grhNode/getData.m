function data = getData(obj, mode)

% get data for this node
% mode can be string: 'inputs', 'outputs'
% mode can be integer specifying dimensions
% mode omitted means all dimensions

if nargin == 1
    dims = 1:size(obj.data.data, 2);
else
    if isstr(mode)
        if strcmp(mode, 'inputs')
            dims = 1:obj.data.input_dim;
        else
            dims = obj.data.input_dim+(1:obj.data.output_dim);
        end
    else
        dims = mode;
    end
end

data = obj.data.data(obj.dataIDs, dims);

