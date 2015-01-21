function obj = addInputDimension(obj, newColumn)

% obj = addInputDimension(obj, newColumn)
%
% newColumn is new column of data to add at the end of existing input dims

obj.data      = [obj.data(:, 1:obj.input_dim) newColumn obj.data(:, obj.input_dim+1:end)];
obj.range     = [obj.range(:, 1:obj.input_dim) [min(newColumn); max(newColumn)] obj.range(:, obj.input_dim+1:end)];
obj.input_dim = obj.input_dim + 1;
