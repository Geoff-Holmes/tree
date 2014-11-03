function limits = drawNode(obj, zeroPoint, opts)

% recursive function called by drawTree.m for graphical output of entire
% tree structure

% output the split criteria inequality <= on left > on right
text(zeroPoint(1), zeroPoint(2), sprintf('x%d <> %.3f', obj.splitVar, obj.splitVal), 'horizontalAlignment', 'center', 'verticalAlignment', 'bottom');

% define extents of horizontal branch line and draw
x = zeroPoint(1)+[-1;1]/2^obj.depth;
y = zeroPoint(2)*[1;1];
line(x, y)
% draw horizontal lines to next leaf / node
line(x(1)*[1;1], [y(1); y(1)-opts.d1])
line(x(2)*[1;1], [y(1); y(1)-opts.d1])

% test for continuance of left branch
if ~isempty(obj.Lchild.splitVar)
    % draw subnode
    limits = drawNode(obj.Lchild, [x(1) y(1)-opts.d2], opts);
    leftLim = limits(1);
    bottomLimL = limits(3);
else
    % write number of data elements at leaf
    leftLim = x(1);
    bottomLimL = y(1)-opts.d2;
    text(leftLim, y(1)-opts.d2, sprintf('%d', size(obj.Lchild.data, 1)), 'horizontalAlignment', 'center', 'verticalAlignment', 'bottom');
end

% test for continuance of right branch
if ~isempty(obj.Rchild.splitVar)
    % draw subnode
    limits = drawNode(obj.Rchild, [x(2) y(1)-opts.d2], opts);
    rightLim = limits(2);
    bottomLimR = limits(3);
else
    % write number of data elements at leaf
    rightLim = x(2);
    bottomLimR = y(1)-opts.d2;
    text(rightLim, y(1)-opts.d2, sprintf('%d', size(obj.Rchild.data, 1)), 'horizontalAlignment', 'center', 'verticalAlignment', 'bottom');
end

% update limits of graphical output
limits = [leftLim rightLim min(bottomLimL, bottomLimR)];

