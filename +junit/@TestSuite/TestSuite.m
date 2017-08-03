classdef TestSuite < handle
    %TESTSUITE JUNIT TEST SUITE OBJECT.
    %   TestSuite object for outputting Jenkins compatible junit xml files.
    %
    %   TestSuite(name) creates a test suite with given name.
    % 
    % Example:
    %   test_suite = TestSuite;
    %   test_case = TestCase('Example Test Case 1');
    %   test_suite.append(test_case);
    %   % Return xml node
    %   node = test_suite.xml;
    %   % Write the xml to a file.
    %   test_suite.xmlfile('junit.xml');
    %
    %
    % Attributes taken from python-junit-xml:
    % https://github.com/kyrus/python-junit-xml/blob/master/junit_xml/__init__.py
    % TODO: prop(erties)
    
    properties
        name = 'TestSuite' % Default test suite name.
        test_cases = [] % List to store the test cases.
        hostname = getenv('COMPUTERNAME') % Default to the current machine.
        id = '0';
        package  = 'matlab'
        timestamp = datestr(now, 31) % Default to current time.
        prop
        file
        log
        url
    end
    
    methods
        %% Constructor.
        function obj = TestSuite(name)
            if nargin>0
               obj.name = name; 
            end            
        end
        %% TestCase
        % Adding test cases to the test suite.
        function append(self, testcase)
            % Add append the test case to the test suite test cases.
            self.test_cases = [self.test_cases, testcase];
        end
        % Aliases
        function add(self, testcase)
            self.append(testcase);
        end
        % testsuite + testcase.
        function plus(self, testcase)
           self.append(testcase); 
        end
        
        %% Calculated test suite attributes
        function n_tests = tests(self)
            % Number of tests.
            % Count the number of test case elements & return it as a
            % string.
            n_tests = sprintf('%d', numel(self.test_cases));
        end
        
        function n_failures = failures(self)
            % Number of failures.
            % Count the number of test cases that are failures.
            is_failure = arrayfun(@(tc)(tc.is_failure), self.test_cases);
            % Return the string for addAttribute.
            n_failures = sprintf('%d', sum(is_failure));
        end
        
        function n_errors = errors(self)
            % Number of errors.
            % Count the number of test cases that are errors.
            is_error = arrayfun(@(tc)(tc.is_error), self.test_cases);
            % Return the string for addAttribute.
            n_errors = sprintf('%d', sum(is_error));
        end
        
        function n_skipped = skipped(self)
            % Number of skipped tests.
            % Count the number of skipped tests.
            is_skipped = arrayfun(@(tc)(tc.is_error), self.test_cases);
            % Return the string for addAttribute.
            n_skipped = sprintf('%d', sum(is_skipped));
        end
        
        function duration = elapsed_sec(self)
            % Return the durations of each of the test cases.
            durations = arrayfun(@(tc)(tc.elapsed_sec), self.test_cases);
            % Sum the durations and return it as a string for addAttribute.
            duration = sprintf('%.2f', sum(durations));
        end
    end
end

