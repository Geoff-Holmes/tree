function dataIDs = pullDataDown(obj)

% pull data down to this node when needed (to save storing there)

if obj.depth == 1
    dataIDs = 1:obj.data.Ndata;
else
    dataIDs = obj.parent.pullDataDown;
    if obj.leftRight
        dataIDs = dataIDs(obj.data.data(dataIDs, obj.parent.splitVar) >  obj.parent.splitVal);
    else
        dataIDs = dataIDs(obj.data.data(dataIDs, obj.parent.splitVar) <= obj.parent.splitVal);
    end
end
    