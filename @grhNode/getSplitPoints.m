function splitPoints = getSplitPoints(obj, dim)

% get candidate splitpoints (midpoints) along dimension dim of the data for
% this node

temp = sort(unique(obj.data.getInputs(obj.dataIDs, dim)));
splitPoints = (temp(1:end-1) + temp(2:end)) / 2;
