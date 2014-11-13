% test script for piecewise linear 2-d model

clear all
close all

% transition probabilities
p = [4 1 1 1];
p = cumsum(p);
p = p/max(p);

% viewing
v = [0 30];
a = [1 0]/10;

% creat data object
N = 100; % for NxN grid of datapoints (evenly spaced)
x = 1:N;
y = 1:N;
% make input grid
[x, y] = meshgrid(x,y);
% create data object
data = [x(:) y(:) zeros(N^2,1)];
% create matrix for surf later
z = zeros(N);

% intial graphics
s = surf(x,y,z);
view(v)
axis([0 100 0 100 -1000 1000])
axis off

% initialise tree with this data
t = grhTree(grhData(data));

counter = 0;

% animate tree
while true
    
    counter = counter + 1;
    
if rand < p(1)
%     fprintf('\nGrowing:')
    t.randomGrow;
%     fprintf('\n')    
else
    if rand < p(2)
%         fprintf('\nPruning:')
        t.randomPrune;
%         fprintf('\n')  
    else
        if rand < p(3)
%             fprintf('\nSwapping:')
            t.randomSwap;
%             fprintf('\n')
        else
%             fprintf('\nChanging:')
            t.randomChange;
%             fprintf('\n')    
        end
    end
end

for thisLeaf = t.leaves
    t.data.setOutputs(thisLeaf.dataIDs, 1, [ones(numel(thisLeaf.dataIDs),1) thisLeaf.data.getInputs(thisLeaf.dataIDs)] * thisLeaf.model'); %+rand*randn(length(thisLeaf.dataIDs),1)*33);
    data = t.data.getData(thisLeaf.dataIDs);
    inds = (data(:,2)-1)*N + data(:,1);
    z(inds) = data(:,3);
       
end

set(s, 'ZData', z);
v(2) = 30 + 10 * sin(counter/20);
v = v + a;
% a = a / norm(a);
view(v)

pause(.01)

end