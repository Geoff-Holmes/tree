function obj = splitNode(obj, splitVar, splitVal)

obj.splitVar = splitVar;
obj.splitVal = splitVal;

leftMembers  = obj.members(obj.members(:,splitVar) <= splitVal, :);
rightMembers = obj.members(obj.members(:,splitVar) >  splitVal, :);

obj.Lchild = grhNode(leftMembers );
obj.Rchild = grhNode(rightMembers);

end
