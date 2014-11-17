function obj = splitNode(obj, splitVar, splitVal)

% form two new nodes by splitting calling node on variable splitVar at
% value splitVal

if ~obj.splitVar
    % set the fields on parent node
    obj.splitVar = uint8(splitVar);
    obj.splitVal = splitVal;

    % get this leafs data on chosen variable / dimension
    data = obj.data.data(obj.dataIDs, splitVar);
    % split the data
    leftDataIDs  = obj.dataIDs(data <= splitVal);
    rightDataIDs = obj.dataIDs(data >  splitVal);

    
    % permute parent model
    Lmodel = obj.model + randn(1,obj.data.input_dim+1);
    Rmodel = obj.model + randn(1,obj.data.input_dim+1);
    % create the new nodes
    obj.Lchild = grhNode(obj, leftDataIDs,  false, Lmodel);
    obj.Rchild = grhNode(obj, rightDataIDs, true, Rmodel);
    
    % purge data from new parent to save memory
    obj.dataIDs = uint16([]);
    
else
    % fprintf('\nNode is already split\n')
end
