
function plotNodeData(obj)

data = obj.data;
d1 = sum(data(:,1) == data(1,1));
d2 = sum(data(:,2) == data(1,2));
x  = reshape(data(:,1), d1, d2);
y  = reshape(data(:,2), d1, d2);
z  = reshape(data(:,3), d1, d2);
obj.plotHandle = surf(x,y,z)