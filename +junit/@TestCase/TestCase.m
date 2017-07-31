classdef TestCase
    %TESTCASE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        assertions
        elapsed_sec
        timestamp
        classname
        status
        category
        file
        line
        log
        url
        stdout
        stderr
    end
    
    methods
        function node = xml(self, docNode)
            node = docNode.createElement('testcase');
            node.setAttribute('name', self.name);
        end
        function fn(self)
            fields = fieldnames(self);
            for idx = i:numel(fields)
               field = fields{i}; 
            end
           disp(fieldnames(self)) 
        end
        function get(self, value)
           disp('Get!'); 
        end
    end
    
end

