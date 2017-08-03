classdef TestCase < handle
    %TESTCASE Summary of this class goes here
    %   Detailed explanation goes here
    
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
        message
        output
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
        
        
        %% Function to generate node.
        function xmlwrite(self, filename)
            [~, ~, ext] = fileparts(filename);
            if ~strcmpi(ext, '.xml')
                filename = sprintf('%s.xml', filename);
            end
            % Write the test suite xml to a given file name.
            xmlwrite(filename,self.xml);
        end
        
        function node = xml(self, docNode)
            if nargin<2
                ts = junit.TestSuite;
                ts.test_cases = [self];
                node = ts.xml();
                return
            end
            
            
            % Create a XML Node element from docNode.
            node = docNode.createElement('testcase');
            % Get all of the fields of self.
            fields = fieldnames(self);
            % For each of the object fields.
            for idx = 1:numel(fields)
                % Pull out the field name from the field cell array based
                % on the loop index.
                field = fields{idx};
                
                % Don't put in empty fields.
                % Continue.
                if isempty(self.(field))
                    continue;
                end
                
                % Skip the type, message & output fields.
                % It is used for the failed, error and skipped Test Case
                % type and addressed below.
                if strcmp(field, 'message')
                    continue;
                end
                if strcmp(field, 'output')
                    continue;
                end
                
                % If the node has standard output (stdout) specified.
                % Create a node for it with the name system-out.
                if strcmp(field, 'stdout')
                    stdout_node = docNode.createElement('system-out');
                    stdout_node.appendChild(docNode.createTextNode(self.stdout));
                    % Append it to the node.
                    node.appendChild(stdout_node);
                    % Continue to loop through fields.
                    continue;
                end
                
                % If the node has standard error (stderr) specified.
                % Create a node for it with the name system-err.
                if strcmp(field, 'stderr')
                    stderr_node = docNode.createElement('system-err');
                    stderr_node.appendChild(docNode.createTextNode(self.stderr));
                    % Append it to the node.
                    node.appendChild(stderr_node);
                    % Continue to loop through.
                    continue;
                end
                
                if strcmp(field, 'type')
                    switch self.(field)
                        case 0
                            continue
                        case 1
                            status_node = docNode.createElement('failure');
                            status_node.setAttribute('type', 'failure');
                        case 2
                            status_node = docNode.createElement('error');
                            status_node.setAttribute('type', 'error');
                        case 3
                            status_node = docNode.createElement('skipped');
                            status_node.setAttribute('type', 'skipped');
                        otherwise
                            error('Unknown type: %f', self.(field));
                    end
                    if ~isempty(self.message)
                        status_node.setAttribute('message', self.message);
                    end
                    if ~isempty(self.output)
                        status_node.appendChild(docNode.createTextNode(self.output));
                    end
                    node.appendChild(status_node);
                    continue
                end
                
                
                % Get the value of the field.
                tmp_value = self.(field);
                % If it is numeric.
                if isnumeric(tmp_value)
                    % Convert it to a string.
                    value = num2str(tmp_value);
                else
                    % If it is not, pass it through.
                    value = tmp_value;
                end
                % Set the test attribute field with given value.
                node.setAttribute(field, value)
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

