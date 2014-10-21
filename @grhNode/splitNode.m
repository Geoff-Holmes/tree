function obj = splitNode(obj, splitVar, splitVal)

obj.splitVar = splitVar;
obj.splitVal = splitVal;

leftMembers  = obj.members(obj.members(:,splitVar) <= splitVal, :);
rightMembers = obj.members(obj.members(:,splitVar) >  splitVal, :);

obj.Lchild = grhNode(obj, leftMembers );
obj.Rchild = grhNode(obj, rightMembers);

end
