classdef node
    
    properties
        
        elements;
        Lchild = [];
        Rchild = [];
        
    end
    
    methods
        
        function obj = node(memberIDs)
            
            obj.elements = memberIDs;
            
        end
    end
end
            