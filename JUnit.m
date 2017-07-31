classdef JUnit
    %JUNIT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        xml
    end
    
    methods
        function obj = JUnit(xml)
            if nargin>1
                obj.xml = xml;
            end
        end
    end
    
end

