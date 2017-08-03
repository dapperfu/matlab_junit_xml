classdef TestCase < handle
    %TESTCASE JUnit test case object.
    %   Test case object for outputting Jenkins compatible junit xml files.
    %
    %   TestSuite(name) creates a test suite with given name.
    % 
    % Example:
    %   test_case = TestCase('Minimal JUnit Test Case')
    %   test_case.xmlwrite('junit.xml')
    %
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
    properties
        name
        assertions
        elapsed_sec = 0
        timestamp = datestr(now, 31)
        classname
        status
        category
        file
        line
        log
        url
        stdout = ''
        stderr = ''
        
        type = 0
        message = ''
        output = ''
    end
    
    methods
        function obj = TestCase(name, classname)
            if nargin>0
                obj.name = name;
            end
            if nargin>1
                obj.classname = classname;
            end
        end
        %% Methods to set non-success messages and outputs.
        function failure(self, message, output)
            self.type = 1;
            if ~isempty(message) && nargin>1
                self.message=message;
            end
            if ~isempty(output) && nargin>2
                self.output=output;
            end
        end
        function error(self, message, output)
            if nargin==2 && isa(message, 'MException')
                
                self.message = message.message;
                self.output = junit.stackDump(self.stack);
                return
            end
            self.type = 2;
            if nargin>1 && ~isempty(message)
                self.message=message;
            end
            if nargin>2 && ~isempty(output)
                self.output=output;
            end
        end
        function skipped(self, message, output)
            self.type = 3;
            if ~isempty(message) && nargin>1
                self.message=message;
            end
            if ~isempty(output) && nargin>2
                self.output=output;
            end
        end
        
        %% Methods to determine test case state.
        function success = is_success(self)
            % Return if the test is a success.
            success = self.type == 0;
        end
        function failure = is_failure(self)
            % Return if the test is a failure.
            failure = self.type == 1;
        end
        function error = is_error(self)
            % Return if the test is an error.
            error = self.type == 2;
        end
        function skipped = is_skipped(self)
            % Return if the test is skipped.
            skipped = self.type == 3;
        end
        
        function duration = time(self)
            % Return the elapsed time of the test.
            if isnumeric(self.elapsed_sec)
                % If elapsed_sec is numeric, return it as is.
                duration = self.elapsed_sec;
            else
                % Otherwise convert the string to a double  first.
                duration = str2double(self.elapsed_sec);
            end
        end
    end
end

