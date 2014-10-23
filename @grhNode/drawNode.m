function limits = drawNode(obj, zeroPoint, opts)

if nargin < 3
    opts = struct('d0', 0.14, 'd1', 0.25, 'd2', 0.5, 'd3', 0.75, 'd4', 0.025);
end

text(zeroPoint(1), zeroPoint(2), sprintf('x%d <> %.3f', obj.splitVar, obj.splitVal), 'horizontalAlignment', 'center', 'verticalAlignment', 'bottom')

x = zeroPoint(1)+[-1;1]*1/obj.depth;
y = zeroPoint(2)*[1;1]; 5-opts.d1;
line(x, y)
line(x(1)*[1;1], [y(1); y(1)-opts.d2])
line(x(2)*[1;1], [y(1); y(1)-opts.d2])

if ~isempty(obj.Lchild.splitVar)
    limits = drawNode(obj.Lchild, [x(1) y(1)-opts.d3], opts);
    leftLim = limits(1);
    bottomLimL = limits(3);
else
    leftLim = x(1);
    bottomLimL = y(1)-opts.d3;
    text(leftLim, y(1)-opts.d3, sprintf('%d', size(obj.Lchild.data, 1)), 'horizontalAlignment', 'center', 'verticalAlignment', 'bottom');
end
if ~isempty(obj.Rchild.splitVar)
    limits = drawNode(obj.Rchild, [x(2) y(1)-opts.d3], opts);
    rightLim = limits(2);
    bottomLimR = limits(3);
else
    rightLim = x(2);
    bottomLimR = y(1)-opts.d3;
    text(rightLim, y(1)-opts.d3, sprintf('%d', size(obj.Rchild.data, 1)), 'horizontalAlignment', 'center', 'verticalAlignment', 'bottom');
end

limits = [leftLim rightLim min(bottomLimL, bottomLimR)];

