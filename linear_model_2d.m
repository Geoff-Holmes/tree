% test script for piecewise linear 2-d model

clear all
% t = grhTree([2 1], [zeros(1,3); ones(1,3)])
x = 1:10;
y = 1:10;
[x,y] = meshgrid(x,y);
data = [x(:) y(:) zeros(100,1)];

t = grhTree(data)

for i = 1:100
    
    leaf           = t.nodes(t.leaves(randi(length(t.leaves))));
    dim            = randi(t.input_dim);
    try
        [~, midpoints] = leaf.dataSortByDim(dim);
        splitPoint     = midpoints(randi(length(midpoints)));
        leaf.splitNode(dim, splitPoint);
    end
    
end

t.drawTree;