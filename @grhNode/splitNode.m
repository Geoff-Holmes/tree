function obj = splitNode(obj, splitVar, splitVal)

if isempty(obj.splitVar)
    obj.splitVar = splitVar;
    obj.splitVal = splitVal;

    leftData  = obj.data(obj.data(:,splitVar) <= splitVal, :);
    rigftData = obj.data(obj.data(:,splitVar) >  splitVal, :);

    obj.Lchild = grhNode(obj, leftData );
    obj.Rchild = grhNode(obj, rigftData);
else
    fprintf('\nNode is already split\n')
end
