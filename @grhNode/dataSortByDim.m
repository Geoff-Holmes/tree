function [sortedData, midPoints] = dataSortByDim(obj, splitVar)

% sort data and get mid points on chosen axis (splitVar) for all datapoints
% on this mode

% extract data values on chosen axis and sort
[temp, inds] = sort(obj.data(:, splitVar));
% calculate midpoints
midPoints = (temp(1:end-1) + temp(2:end)) / 2;
% return full sorted data
sortedData = obj.data(inds, :);
