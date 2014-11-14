function t = createTestData(N, Nsplits)

% create a dataset

if ~nargin
    N = 10000;
    Nsplits = 10;
end

t = grhTree(grhData(rand(N, 3)));

for splot = 1:Nsplits
    
    t.randomGrow;
    
end

for thisLeaf = t.leaves
        output = [ones(numel(thisLeaf.dataIDs),1) thisLeaf.data.getInputs(thisLeaf.dataIDs)] * thisLeaf.model';%+rand*randn(length(thisLeaf.dataIDs),1)*33;
        t.data.setOutputs(thisLeaf.dataIDs, 1, output);
end

figure;
data = t.data.getData;
plot3(data(:,1), data(:,2), data(:,3), '.')