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
                   stdout = docNode.createElement('system-out'); 
                   stdout.appendChild(docNode.createTextNode(self.stdout));
                   node.appendChild(stdout);
                   continue;
                end
                if strcmp(field, 'stderr')
                   stderr = docNode.createElement('system-err'); 
                   stderr.appendChild(docNode.createTextNode(self.stderr));
                   node.appendChild(stderr);    
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
            
%             sysout = docNode.createElement('system-out');
% sysout.appendChild(docNode.createTextNode(''));
% testcase.appendChild(sysout)
% 
% syserr = docNode.createElement('system-err'); 
% syserr.appendChild(docNode.createTextNode(''));
% testcase.appendChild(syserr)

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

