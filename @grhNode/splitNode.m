function obj = splitNode(obj, splitVar, splitVal)

% form two new nodes by splitting calling node on variable splitVar at
% value splitVal

if isempty(obj.splitVar)
    % set the fields on parent node
    obj.splitVar = uint8(splitVar);
    obj.splitVal = splitVal;

    if ~isempty(obj.dataIDs)
        % get this nodes data on chosen variable / dimension
        data = obj.data.getInputs(obj.dataIDs, splitVar);
        % split the data
        leftDataIDs  = obj.dataIDs(data <= splitVal);
        rightDataIDs = obj.dataIDs(data >  splitVal);
    else
        leftDataIDs  = [];
        rightDataIDs = [];
    end
    
    % permute parent model
    Lmodel = obj.model + randn(1,obj.data.input_dim+1);
    Rmodel = obj.model + randn(1,obj.data.input_dim+1);
    % create the new nodes
    obj.Lchild = grhNode(obj, leftDataIDs,  logical(0), Lmodel);
    obj.Rchild = grhNode(obj, rightDataIDs, logical(1), Rmodel);
    
    % purge data from new parent to save memory
    obj.dataIDs = uint16([]);
    
else
    % fprintf('\nNode is already split\n')
end
