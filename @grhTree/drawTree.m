function handle = drawTree(obj, opts)

handle = figure; hold on;
refPoint = [0 0];
if nargin == 1
    limits = obj.nodes(1).drawNode(refPoint);
else
    limits = obj.nodes(1).drawNode(refPoint, opts);
end

axis([limits * 1.1 0.25]);