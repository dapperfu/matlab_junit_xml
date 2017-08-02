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
            
            elapsed_sec = 0;
            
            for idx = 1:numel(self.test_cases)
                test_case = self.test_cases(idx);
                test_case_node = test_case.xml(docNode);
                node.appendChild(test_case_node);
                
                if ~isempty(test_case.elapsed_sec)
                    if isnumeric(test_case.elapsed_sec)
                        elapsed_sec = elapsed_sec + test_case.elapsed_sec;                    
                    else
                        elapsed_sec = elapsed_sec + str2double(test_case.elapsed_sec);
                    end
                end                
            end
            
            node.setAttribute('elapsed_sec', elapsed_sec)
            
            if nargin<2
                docRootNode.appendChild(node);
                node = docNode;
            end
        end
        
        function xmlwrite(self, filename)
            xmlwrite(filename,self.xml);   
        end
    end
    
end

