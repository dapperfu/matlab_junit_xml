%% Example 10
% 'Real World' use case.

test_suite = junit.TestSuite(sprintf('%s Test Suite', mfilename));

for random_integer = randi([0, 100], 100, 1)
    test_case = junit.TestCase(sprintf('Test Case #%d', random_integer));
    
    
    try
        % Complete failure, just skip the test.
    
        % Test Failure,
        assert(random_integer<10, 'Catastrophic Failure %d<10. Skipping Test', random_integer);
        try
            try
                
            catch Error
                test_case.error(Error.identifier, Error.message);
            end
        catch Fail
            test_case.fail(Fail.identifier, Fail.message);     
        end
    catch Skip
        test_case.skipped(Skip.identifier, Skip.message)
    end
    test_suite.append(test_case);
    % test_suite.test_cases = [test_suite.test_cases, test_case];
end
% Write the TestCase as an xml file with .m filename.
tc.xmlwrite(mfilename);
