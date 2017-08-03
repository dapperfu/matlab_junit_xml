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
            % If there is no parent testsuites node (no docNode passsed in)
            % Generate a top level testsuites document;
            if nargin<2
                docNode = com.mathworks.xml.XMLUtils.createDocument('testsuites');
                docRootNode = docNode.getDocumentElement;
            end
            
            node = docNode.createElement('testsuite');
            % Set calculated test suite attributes.
            node.setAttribute('elapsed_sec', self.time)
            node.setAttribute('tests', self.tests)
            node.setAttribute('failures', self.failures)
            node.setAttribute('errors', self.errors)
            node.setAttribute('skipped', self.skipped)
            
            % For each of the test cases.
            for idx = 1:numel(self.test_cases)
                % Get the test case.
                test_case = self.test_cases(idx);
                % Get the test case node.
                test_case_node = test_case.xml(docNode);
                % Add it to the test suite.
                node.appendChild(test_case_node);
            end
            
            if nargin<2
                % If no parent level testsuites node was passed in
                % Append the current node to the generated node
                % and return that.
                docRootNode.appendChild(node);
                node = docNode;
            end
        end
        
        function xmlwrite(self, filename)
            [~, ~, ext] = fileparts(filename);
            if ~strcmpi(ext, '.xml')
                filename = sprintf('%s.xml', filename);
            end
            % Write the test suite xml to a given file name.
            xmlwrite(filename,self.xml);
        end
        
        function plus(self, other)
            if isa(other, 'junit.TestCase')
                self.append(other);
                return
            end
            error('Unknown additive class');
        end
        
        %% TestCase
        function append(self, testcase)
            self.test_cases = [self.test_cases, testcase];
        end
        
        %% Calculated test suite attributes
        function n_tests = tests(self)
            % Number of tests.
            n_tests = sprintf('%d', numel(self.test_cases));
        end
        
        function n_failures = failures(self)
            % Number of failures.
            is_failure = arrayfun(@(tc)(tc.is_failure), self.test_cases);
            n_failures = sprintf('%d', sum(is_failure));
        end
        
        function n_errors = errors(self)
            % Number of errors.
            is_error = arrayfun(@(tc)(tc.is_error), self.test_cases);
            n_errors = sprintf('%d', sum(is_error));
        end
        
        function n_skipped = skipped(self)
            % Number of skipped tests.
            is_skipped = arrayfun(@(tc)(tc.is_error), self.test_cases);
            n_skipped = sprintf('%d', sum(is_skipped));
        end
        
        function duration = time(self)
            % Total duration spent in a test.
            durations = arrayfun(@(tc)(tc.time), self.test_cases);
            duration = sprintf('%.2f', sum(durations));
        end
    end
end

