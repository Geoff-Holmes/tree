function handle = drawTree(obj, opts)

% handle to return
handle = figure; hold on; axis off;
% starting point at base of tree
refPoint = [0 0];
% call function that recursively draws each node
if nargin == 1
    limits = obj.nodes(1).drawNode(refPoint);
else
    limits = obj.nodes(1).drawNode(refPoint, opts);
end

% ensure whole graphic is visible
axis([limits * 1.1 0.25]);