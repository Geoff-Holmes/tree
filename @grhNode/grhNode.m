classdef grhNode
    
    properties
        
        elements;
        splitVar;
        splitVal;
        Lchild = [];
        Rchild = [];
        
    end
    
    methods
        
        function obj = grhNode(memberIDs)
            
            obj.elements = memberIDs;
            
        end
    end
end
            