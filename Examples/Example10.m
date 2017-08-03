%% Example 10
% Full 'real world' example with passing, skipping & errors.

% Create a test suite based on the filename.
test_suite = junit.TestSuite(sprintf('%s Test Suite', mfilename));
% Number of test cases to create.
n_test_cases = 100;
% Random integer: [0, 100].
random_integers = randi([0, 100], 1, n_test_cases);
%
for idx = 1:numel(random_integers)
    random_integer = random_integers(idx);
    % Create a test case.
    test_case = junit.TestCase(sprintf('Test Case #%d', random_integer));
    try
        % Complete failure, just skip the test.
        assert(random_integer>10, 'Catastrophic Failure %d<10. Skipping Test', random_integer);
        try
            % Test failed to run.
            assert(random_integer>20, 'Test Failed: %d<20.', random_integer);
            try
                % Test had an error during run.
                assert(random_integer>40, 'Error runnining the test: %d<40', random_integer);
                % Passed all the tests, record a success.
                test_case.stdout=sprintf('Test Success! %d', random_integer);
            catch Error                
                % Test had an error during execution.
                test_case.error(Error.identifier, Error.message);
                % Set the standard error.
                test_case.stderr=Error.message;
            end
        catch Fail
            % Test failed to run.
            test_case.fail(Fail.identifier, Fail.message);
        end
    catch Skip
        % Test was skipped.
        test_case.skipped(Skip.identifier, Skip.message)
    end
    % Add the current test case to the test suite's test cases.
    test_suite.append(test_case);
    % test_suite.test_cases = [test_suite.test_cases, test_case];
end
% Write the TestCase as an xml file with .m filename.
test_suite.xmlwrite(mfilename);
