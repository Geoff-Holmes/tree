function data = getData(obj, inds)

% get full data by indicies

if nargin == 1
    inds = 1:obj.Ndata;
end
    
data = obj.data(inds, :);