classdef TestSuite < handle
    %TESTSUITE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name = ''
        test_cases = []
        hostname = getenv('COMPUTERNAME')
        id
        package 
        timestamp = datestr(now, 31) % Default to current time.
        prop
        file
        log
        url
    end
    
    methods
        %% TestCase
        function append(self, testcase)
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

