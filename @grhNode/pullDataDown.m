function data = pullDataDown(obj)

% pull data down to this node when needed (to save storing there)

if obj.depth == 1
    data = 1:obj.data.Ndata;
else
    data = obj.parent.pullDataDown;
    if obj.leftRight
        data = data(obj.data.getInputs(data, obj.parent.splitVar) >  obj.parent.splitVal);
    else
        data = data(obj.data.getInputs(data, obj.parent.splitVar) <= obj.parent.splitVal);
    end
end
    