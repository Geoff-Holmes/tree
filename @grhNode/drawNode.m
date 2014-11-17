function limits = drawNode(obj, zeroPoint, opts)

% recursive function called by drawTree.m for graphical output of entire
% tree structure

% reduce the vertical line depth
fac = .8;
opts.d1 = opts.d1*fac;
opts.d2 = opts.d1+.25*fac;

% output the split criteria inequality <= on left > on right
% text(zeroPoint(1), zeroPoint(2), sprintf('x%d <> %.3f', obj.splitVar, obj.splitVal), 'horizontalAlignment', 'center', 'verticalAlignment', 'bottom');
text(zeroPoint(1), zeroPoint(2), sprintf('node %d : %d', obj.ID, numel(obj.dataIDs)), 'horizontalAlignment', 'center', 'verticalAlignment', 'bottom');
% text(zeroPoint(1), zeroPoint(2), sprintf('%d', size(obj.data, 1)), 'horizontalAlignment', 'center', 'verticalAlignment', 'bottom');

% define extents of horizontal branch line and draw
x = zeroPoint(1)+[-1;1]/2^double(obj.depth);
y = zeroPoint(2)*[1;1];
line(x, y)
% draw horizontal lines to next leaf / node
line(x(1)*[1;1], [y(1); y(1)-opts.d1])
line(x(2)*[1;1], [y(1); y(1)-opts.d1])

% test for continuance of left branch
if obj.Lchild.splitVar
    % draw subnode
    limits = drawNode(obj.Lchild, [x(1) y(1)-opts.d2], opts);
    leftLim = limits(1);
    bottomLimL = limits(3);
else
    % write number of data elements at leaf
    leftLim = x(1);
    bottomLimL = y(1)-opts.d2;
%     text(leftLim, y(1)-opts.d2, sprintf('%d', size(obj.Lchild.data, 1)), 'horizontalAlignment', 'center', 'verticalAlignment', 'bottom');
    text(leftLim, y(1)-opts.d2, sprintf('node %d : %d', obj.Lchild.ID, numel(obj.Lchild.dataIDs)), 'horizontalAlignment', 'center', 'verticalAlignment', 'bottom');
end

% test for continuance of right branch
if obj.Rchild.splitVar
    % draw subnode
    limits = drawNode(obj.Rchild, [x(2) y(1)-opts.d2], opts);
    rightLim = limits(2);
    bottomLimR = limits(3);
else
    % write number of data elements at leaf
    rightLim = x(2);
    bottomLimR = y(1)-opts.d2;
%     text(rightLim, y(1)-opts.d2, sprintf('%d', size(obj.Rchild.data, 1)), 'horizontalAlignment', 'center', 'verticalAlignment', 'bottom');
    text(rightLim, y(1)-opts.d2, sprintf('node %d : %d', obj.Rchild.ID, numel(obj.Rchild.dataIDs)), 'horizontalAlignment', 'center', 'verticalAlignment', 'bottom');
end

% update limits of graphical output
limits = [leftLim rightLim min(bottomLimL, bottomLimR)];

