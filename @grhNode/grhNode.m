classdef grhNode
    
    properties
        
        elements;
        Lchild = [];
        Rchild = [];
        
    end
    
    methods
        
        function obj = grhNode(memberIDs)
            
            obj.elements = memberIDs;
            
        end
    end
end
            