% test script for piecewise linear 2-d model

clear all
% t = grhTree([2 1], [zeros(1,3); ones(1,3)])
N = 100;
x = 1:N;
y = 1:N;
[x,y] = meshgrid(x,y);
data = [x(:) y(:) zeros(N^2,1)];
z = zeros(N);

t = grhTree(data)

for i = 1:100
    
    leaf           = t.nodes(t.leaves(randi(length(t.leaves))));
    dim            = randi(t.input_dim);
    try
        [~, midpoints] = leaf.dataSortByDim(dim);
        splitPoint     = midpoints(3+randi(length(midpoints))-6);
        leaf.splitNode(dim, splitPoint);
    end
    
end

t.drawTree;

figure; hold on
for k = t.leaves
    
    thisLeaf = t.nodes(k);
    thisLeaf.model = randi(12, 1, 3) - 6;
    thisLeaf.data(:,end) = thisLeaf.model * [ones(size(thisLeaf.data, 1),1) thisLeaf.data(:,1:end-1)]';
    data = thisLeaf.data;
%     plot3(data(:,1), data(:,2), data(:,3), '.')
    inds = (data(:,2)-1)*N + data(:,1);
    z(inds) = data(:,3)+rand*randn(length(inds),1)*33;
       
end

surf(x,y,z)
set(gca, 'view', [15 25])