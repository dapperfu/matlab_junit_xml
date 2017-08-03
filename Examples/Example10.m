%% Example 10
% 'Real World' use case.

test_suite = junit.TestSuite(sprintf('%s Test Suite', mfilename));

for random_integer = randi([0, 100], 100, 1)
    test_case = junit.TestCase('sprintf
    try
        assert(random_integer<10, 'Catastrophic Failure %d<10. Skipping Test', random_integer);
        try
            try
                
            catch
                
            end
            
        catch
            
        end
    catch
        tc
    end
    
end


% % Create test case object.
% tc = junit.TestCase;
% % Generate a standard out
% tc.stdout = matlab_ipsum;
% % Write the TestCase as an xml file with .m filename.
% tc.xmlwrite(mfilename);
