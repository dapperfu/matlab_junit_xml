classdef TestSuite < handle
    %TESTSUITE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name = 'TestSuite'
        test_cases = []
        hostname = getenv('COMPUTERNAME')
        id
        package
        timestamp = datestr(now, 31)
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
            
            node.setAttribute('elapsed_sec', self.time)
            node.setAttribute('failures', self.failures)
            node.setAttribute('errors', self.errors)
            node.setAttribute('skipped', self.skipped)
            
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
        
        
        function xmlwrite(self, filename)
            xmlwrite(filename,self.xml);
        end
        
        function n_tests = tests(self)
            n_tests = numel(self.test_cases);
        end
        
        function n_failures = failures(self)
            is_failure = arrayfun(@(tc)(tc.is_failure), self.test_cases);
            n_failures = sprintf('%d', sum(is_failure));
        end
        
        function n_errors = errors(self)
            is_error = arrayfun(@(tc)(tc.is_error), self.test_cases);
            n_errors = sprintf('%d', sum(is_error));
        end
        
        function n_skipped = skipped(self)
            is_skipped = arrayfun(@(tc)(tc.is_error), self.test_cases);
            n_skipped = sprintf('%d', sum(is_skipped));
        end
        
        function duration = time(self)
            durations = arrayfun(@(tc)(tc.time), self.test_cases);
            duration = sprintf('%.2f', sum(durations));
        end
    end
end

