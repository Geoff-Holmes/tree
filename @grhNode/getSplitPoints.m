function [splitPoints, dataIDs] = getSplitPoints(obj, dim)

% get candidate splitpoints (midpoints) along dimension dim of the data for
% this node

% get data
dataIDs = obj.pullDataDown;
temp = sort(obj.data.data(dataIDs, dim));

% weed out repeated data
inds = logical((temp(2:end) - temp(1:end-1)));
temp = temp([inds; true]);

% calculate midpoints
splitPoints = (temp(1:end-1) + temp(2:end)) / 2;
