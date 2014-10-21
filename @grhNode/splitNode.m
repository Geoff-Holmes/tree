function obj = splitNode(obj, splitVar, splitVal)

if isempty(obj.splitVar)
    obj.splitVar = splitVar;
    obj.splitVal = splitVal;

    leftData  = obj.data(obj.data(:,splitVar) <= splitVal, :);
    rigftData = obj.data(obj.data(:,splitVar) >  splitVal, :);

    obj.Lchild = grhNode(obj, leftData,  0);
    obj.Rchild = grhNode(obj, rigftData, 1);
else
    fprintf('\nNode is already split\n')
end
