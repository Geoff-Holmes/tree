function obj = drawTree(obj, mode, lag)

% plot tree by calling recursive node plotting function

% if tree has no branches don't plot
if obj.total_depth == 1
%     msgbox('Skipped drawing of unbranched tree', 'treePlot', 'warn')
    % fprintf('Skipped drawing of unbranched tree')
    return
end

% set plotting parameters if not specified in function call
if nargin < 2
    mode = 'normal';
end
opts = struct('d1', 0.5, 'd2', 0.75);
% d1 - length of vertical drop lines
% d2 - distance of drop to next starting point (refPoint)

% handle to return
switch lower(mode)
    case 'normal'
        if obj.plotHandle 
            figure(obj.plotHandle);
            clf; hold on; axis off;
        else
            obj.plotHandle = figure; hold on; axis off;
        end
    case 'lag'
        if nargin < 3, lag = 1; end
        if obj.plotHandle 
            obj.plotHandle = figure(obj.plotHandle+1);
            if obj.plotHandle  > lag + 1
                close(obj.plotHandle-lag-1);
            end
            hold on; axis off;
        else
            obj.plotHandle = figure; hold on; axis off;
        end
end

% starting point at base of tree
refPoint = [0 0];

% call function that recursively draws each node
limits = obj.nodes(1).drawNode(refPoint, opts);

% ensure whole graphic is visible
axis([limits * 1.1 0.25]);