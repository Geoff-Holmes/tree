function [splitPoints, dataIDs] = getSplitPoints(obj, dim)

% get candidate splitpoints (midpoints) along dimension dim of the data for
% this node

dataIDs = obj.pullDataDown;
temp = sort(unique(obj.data.getInputs(dataIDs, dim)));
splitPoints = (temp(1:end-1) + temp(2:end)) / 2;
