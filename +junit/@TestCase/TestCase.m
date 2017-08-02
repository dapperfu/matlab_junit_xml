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
        
        message
        type
    end
    
    methods
        function node = xml(self, docNode)
            node = docNode.createElement('testcase');          
            fields = fieldnames(self);
            for idx = 1:numel(fields)          
                field = fields{idx};
                
                % Don't put in empty fields.
                if isempty(self.(field))
                    continue;
                end
                
                if strcmp(field, 'stdout')
                   stdout_node = docNode.createElement('system-out'); 
                   stdout_node.appendChild(docNode.createTextNode(self.stdout));
                   node.appendChild(stdout_node);
                   continue;
                end
                if strcmp(field, 'stderr')
                   stderr_node = docNode.createElement('system-err'); 
                   stderr_node.appendChild(docNode.createTextNode(self.stderr));
                   node.appendChild(stderr_node);    
                   continue;
                end
                
                tmp_value = self.(field);
                if isnumeric(tmp_value)
                    value = num2str(tmp_value);
                else
                    value = tmp_value;
                end
                node.setAttribute(field, value)
            end
        end
        function fn(self)
            fields = fieldnames(self);
            for idx = 1:numel(fields)
                field = fields{idx};
                disp(field);
            end
        end
        
        function is_failure(self)
            
        end
        function is_error(self)
            
        end
        function is_skipped(self)
            
        end
    end
end

