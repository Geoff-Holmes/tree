function obj = drawTree(obj, opts)

% plot tree by calling recursive node plotting function

% if tree has no branches don't plot
if obj.total_depth == 1
%     msgbox('Skipped drawing of unbranched tree', 'treePlot', 'warn')
    fprintf('Skipped drawing of unbranched tree')
    return
end

% set plotting parameters if not specified in function call
if nargin == 1
    opts = struct('d1', 0.5, 'd2', 0.75);
    % d1 - length of vertical drop lines
    % d2 - distance of drop to next starting point (refPoint)
end

% handle to return
if obj.plotHandle > 2
    obj.plotHandle = figure(obj.plotHandle+1); %(obj.plotHandle)
    close(obj.plotHandle-2);
    clf; hold on; axis off;
else
    obj.plotHandle = figure; hold on; axis off;
end
% starting point at base of tree
refPoint = [0 0];

% call function that recursively draws each node
limits = obj.nodes(1).drawNode(refPoint, opts);

% ensure whole graphic is visible
axis([limits * 1.1 0.25]);