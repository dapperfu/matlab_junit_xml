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
        time = 0
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
        %% Object constructor.
        function obj = TestCase(name, classname)
            if nargin>0
                obj.name = name;
            end
            if nargin>1
                obj.classname = classname;
            end
        end
        %% Methods to set non-success messages and outputs.
        function set_message(self, varargin)
            if nargin==2 && isa(varargin{1}, 'MException')
                Error = varargin{1};
                % Get the error message.
                self.message = Error.message;
                % Build the stack.
                self.output = junit.stackDump(Error.stack);
                return;
            else
                if nargin>1
                    self.message=varargin{1};
                end
                if nargin>2
                    self.output=varargin{2};
                end
            end
        end
        
        function failure(self, varargin)
            % Mark Test Case as a failure.
            self.type = 1;
            self.set_message(varargin{:})
        end
        
        
        function error(self, varargin)
            % Mark Test Case as an error.
            self.type = 2;
            self.set_message(varargin{:});
        end
        function skipped(self, varargin)
            % SKIPPED(MESSAGE, OUTPUT)
            % Mark Test Case as skipped.
            self.type = 3;
            self.set_message(varargin{:});
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
        
        function duration = elapsed_sec(self)
            % Return the elapsed time of the test as a double.
            if isnumeric(self.time)
                % If elapsed_sec is numeric, return it as is.
                duration = double(self.time);
            else
                % Otherwise convert the string to a double first.
                duration = str2double(self.time);
            end
        end
    end
end
