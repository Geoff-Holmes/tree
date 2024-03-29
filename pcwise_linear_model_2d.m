% test script for piecewise linear 2-d model

clear all
close all

% transition probabilities
p = [4 1 1 0];
pp=p;
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
sp2 = subplot(1,2,2);
sp1 = subplot(1,2,1);
s = surf(x,y,z);
view(v)
axis([0 100 0 100 -1000 1000])
axis off

% initialise tree with this data
t = grhTree(grhData(data));
t.prior.b = 4;

counter = 0;

% animate tree
while true
    
    tic
    
    if ~mod(counter, 20)
        subplot(sp2), cla; t.drawTree('subplot'); axis off;
        title(sprintf('p = [%.0f %.0f %.0f %.0f] : t.prior.b = %.2f', pp, t.prior.b))
    end
    
    counter = counter + 1;
    
    if rand < .05
        p = randi(5, 1, 4);
        p(1) = p(1)*2;
        pp = p;
        p = cumsum(p);
        p = p/max(p);
    end
    
    if (t.prior.b < 0 && rand<.1) || t.prior.b > 0
    if rand<.1, t.prior.b = randn();end
    end
    
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

subplot(sp1)
set(s, 'ZData', z);
v(2) = 40 + 20 * sin(counter/40);
v = v + a;
% a = a / norm(a);
view(v)

if toc < .1
    pause(.1-toc)
end
end