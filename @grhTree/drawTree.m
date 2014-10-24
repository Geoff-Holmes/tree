function handle = drawTree(obj, opts)

% handle to return
handle = figure; hold on; axis off;
% starting point at base of tree
refPoint = [0 0];
% set plotting parameters if not specified in function call
if nargin == 1
    opts = struct('d1', 0.5, 'd2', 0.75);
    % d1 - length of vertical drop lines
    % d2 - distance of drop to next starting point (refPoint)
end

% call function that recursively draws each node
limits = obj.nodes(1).drawNode(refPoint, opts);

% ensure whole graphic is visible
axis([limits * 1.1 0.25]);