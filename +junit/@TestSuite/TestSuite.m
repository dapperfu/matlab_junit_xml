classdef TestSuite < handle
    %TESTSUITE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name
        test_cases
        hostname
        id
        package
        timestamp
        prop
        file
        log
        url
        stdout
        stderr
    end
    
    methods
        
        function node = xml(self, docNode)
            
            if nargin<2
                docNode = com.mathworks.xml.XMLUtils.createDocument('testsuites');
                docRootNode = docNode.getDocumentElement;
            end
            
            node = docNode.createElement('testsuite');
            node.setAttribute('name', self.name);
            
            for idx = 1:numel(self.test_cases)
                test_case = self.test_cases(idx);
                test_case_node = test_case.xml(docNode);
                node.appendChild(test_case_node);
            end
            
            if nargin<2
                docRootNode.appendChild(node);
                node = docNode;
            end
        end
    end
    
end

