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
                if strcmp(field, 'stdout')
                   
                end
                if strcmp(field, 'stdout')
                    
                end
                node.setAttribute(field, self.(field))
            end
            
            sysout = docNode.createElement('system-out');
sysout.appendChild(docNode.createTextNode(''));
testcase.appendChild(sysout)

syserr = docNode.createElement('system-err'); 
syserr.appendChild(docNode.createTextNode(''));
testcase.appendChild(syserr)

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

