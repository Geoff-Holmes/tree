function obj = splitNode(obj, splitVar, splitVal)

% form two new nodes by splitting calling node on variable splitVar at
% value splitVal

if isempty(obj.splitVar)
    % set the fields on parent node
    obj.splitVar = splitVar;
    obj.splitVal = splitVal;

    if numel(obj.dataIDs)
        % get this nodes data on chosen variable / dimension
        data = obj.data.getInputs(obj.dataIDs, splitVar);
        % split the data
        leftDataIDs  = obj.dataIDs(data <= splitVal);
        rightDataIDs = obj.dataIDs(data >  splitVal);
    else
        leftDataIDs  = [];
        rightDataIDs = [];
    end

    % create the new nodes
    obj.Lchild = grhNode(obj, leftDataIDs,  0);
    obj.Rchild = grhNode(obj, rightDataIDs, 1);
    
%     % purge data from new parent to save memory
%     obj.data = [];
    
else
    fprintf('\nNode is already split\n')
end
