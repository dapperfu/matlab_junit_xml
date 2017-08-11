%% Example 12
% Tested functions to get stack.

function Example12()
test_suite = junit.TestSuite(sprintf('%s Test Suite', mfilename));
% Create a test suite based on the filename.
% Number of test cases to create.
n_test_cases = 100;
% Random integer: [0, 100].
random_integers = randi([0, 100], 1, n_test_cases);
%
for idx = 1:numel(random_integers)
    random_integer = random_integers(idx);
    test_case = fcn2(random_integer, idx);
    % Add the current test case to the test suite's test cases.
    test_suite.append(test_case);
end
% Write the TestCase as an xml file with .m filename.
test_suite.xmlwrite(mfilename);
type([mfilename '.xml']);
end

function test_case = fcn2(random_integer, idx)
% Create a test case.
test_case = junit.TestCase(sprintf('Test Case #%d', idx));
try
    assert(random_integer>10)
    test_case.stdout=sprintf('Test Success! %d', random_integer);
catch Error
    % Test was skipped.
    test_case.error(Error);
end
end
