classdef grhNode < handle
    
    properties
        
        members;        % data elements on this leaf / node
        model;          % handle to model applying if leaf
        splitVar;
        splitVal;
        Lchild = [];    % pointers to children
        Rchild = [];    %
        
    end
    
    methods
        
        function obj = grhNode(members)
            
            obj.members = members;
            
        end
    end
end
            