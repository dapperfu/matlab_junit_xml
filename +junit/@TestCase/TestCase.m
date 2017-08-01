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
            if numel<2
                docNode = com.mathworks.xml.XMLUtils.createDocument('testsuites');
                docRootNode = docNode.getDocumentElement;
            end
            
            node = docNode.createElement('testcase');
            node.setAttribute('name', self.name);
            
            if nargin<2
                docRootNode.appendChild(node);
                node = docNode;
            end
        end
        function fn(self)
            fields = fieldnames(self);
            for idx = 1:numel(fields)
                field = fields{idx};
                disp(field);
            end
        end
        function get(self, value)
            disp('Get!');
        end
    end
    
end

