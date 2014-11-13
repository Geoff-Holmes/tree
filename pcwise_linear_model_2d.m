% test script for piecewise linear 2-d model

clear all
% creat data object
N = 100; % for NxN grid of datapoints (evenly spaced)
x = 1:N;
y = 1:N;
% make input grid
[x,y] = meshgrid(x,y);
% create data object
data = grhData([x(:) y(:) zeros(N^2,1)]);
% create matrix for surf later
z = zeros(N);

% initialise tree with this data
t = grhTree(data)

% grow tree a bit
for i = 1:10
    t.randomGrow;
end

t.drawTree;

% figure; hold on
% for k = t.leaves
%     
%     thisLeaf = t.nodes(k);
%     thisLeaf.model = randi(12, 1, 3) - 6;
%     thisLeaf.data(:,end) = thisLeaf.model * [ones(size(thisLeaf.data, 1),1) thisLeaf.data(:,1:end-1)]';
%     data = thisLeaf.data;
% %     plot3(data(:,1), data(:,2), data(:,3), '.')
%     inds = (data(:,2)-1)*N + data(:,1);
%     z(inds) = data(:,3)+rand*randn(length(inds),1)*33;
%        
% end
% 
% surf(x,y,z)
% set(gca, 'view', [15 25])