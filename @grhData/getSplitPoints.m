function splitPoints = getSplitPoints(obj, dim, inds)

% get candidate splitpoints (midpoints) along dimension dim of subset of
% data defined by indices inds

if nargin < 3
    inds = 1:obj.Ndata;
end
    
temp = sort(unique(obj.data(inds, dim)));
splitPoints = (temp(1:end-1) + temp(2:end)) / 2;
