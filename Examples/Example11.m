%% Example 11
% Full 'real world' example with only errors.

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
    test_case = junit.TestCase(sprintf('Test Case #%d', idx));
    try
        assert(random_integer>10)
        test_case.stdout=sprintf('Test Success! %d', random_integer);
    catch Error
        % Test was skipped.
        test_case.error(Error)
    end
    % Add the current test case to the test suite's test cases.
    test_suite.append(test_case);
    % test_suite.test_cases = [test_suite.test_cases, test_case];
end
% Write the TestCase as an xml file with .m filename.
test_suite.xmlwrite(mfilename);
type([mfilename '.xml']);
