% test grow and prune

t = grhTree(rand(3,33)')
for i = 1:5
    t.randomGrow;
end
for i = 1:100
if rand < .5
    t.randomGrow;
    fprintf('\nGrow\n')
else
    if rand < .5
        t.randomPrune;
        fprintf('\nPrune\n')
    else
        t.randomChange;
        fprintf('\nChange\n')
    end
end
pause() 
% close all
t.drawTree;
% title(sprintf('depth %d', t.total_depth))
% pause()
end
