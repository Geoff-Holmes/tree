tree
====

Tree and Node classes for binary tree structure.


Example usage:

% create a tree containing a random 100 point dataset

% data has 3 input dimensions and one output dimension

t = grhTree(rand(100, 4));

% add an initial branch on the first input dimension at value 0.5

n1 = t.nodes(1).splitNode(1, 0.5);

% add further splits

n2 = n1.Lchild.splitNode(2, 0.75);

n3 = n2.Rchild.splitNode(3, 0.25);

% draw the resulting tree

fig = t.drawTree;

% view the data range of a particular leaf or node

n3.Rchild.showNodeRegion;

% find the leaf to which a testpoint belongs (in this case one of the datapoints)

nt = t.getNode(t.data(1,:))

% confirm that this point is on that leaf

t.data(1,:)

nt.data(1,:)







