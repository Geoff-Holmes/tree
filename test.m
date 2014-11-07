% test grow and prune

clear all
close all
p = [1 1 1 0];
p = cumsum(p);
p = p/max(p);
flag = 0;

t = grhTree(rand(333,22));
for i = 1:5
    t.randomGrow;
end

counter = 0;
while true
counter = counter+1;
if rand < p(1)
    fprintf('\nGrowing:')
    t.randomGrow;
%     fprintf('\n')    
else
    if rand < p(2)
        fprintf('\nPruning:')
        t.randomPrune;
%         fprintf('\n')  
    else
        if rand < p(3)
            fprintf('\nSwapping:')
            t.randomSwap;
%             fprintf('\n')
        else
            fprintf('\nChanging:')
            t.randomChange;
%             fprintf('\n')    
        end
    end
end
% pause() 
% close all
% t.drawTree;

t.testDepthConsistency;
if isfield(t.health, 'depthFail'), break;
% else fprintf('\npassed depth\n')
end

t.testAllDataAtLeaves;
if isfield(t.health, 'lostData'), break;
end

t.testDataAllLengths;
if isfield(t.health, 'allDataLengths'), break;
end

t.testDataPlacement('all');
if isfield(t.health, 'misplacedData'), break;
end

t.testParentChildConsistency;
if isfield(t.health, 'relationError'), break;
end

if ~isempty(fields(t.health))
    t.health
end
end