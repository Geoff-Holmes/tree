function obj = splitNode(obj, splitVar, splitVal)

% form two new nodes by splitting calling node on variable splitVar at
% value splitVal

if isempty(obj.splitVar)
    % set the fields on parent node
    obj.splitVar = splitVar;
    obj.splitVal = splitVal;

    if numel(obj.data)
        % split the data
        leftData  = obj.data(obj.data(:,splitVar) <= splitVal, :);
        rightData = obj.data(obj.data(:,splitVar) >  splitVal, :);
    else
        leftData  = [];
        rightData = [];
    end

    % create the new nodes
    obj.Lchild = grhNode(obj, leftData,  0);
    obj.Rchild = grhNode(obj, rightData, 1);
else
    fprintf('\nNode is already split\n')
end
