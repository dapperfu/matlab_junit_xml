%% Example 13
% Tested functions.
% Abusing globals to keep track of test cases.

function Example13()
global test_suite

test_suite = junit.TestSuite(sprintf('%s Test Suite', mfilename));
% Create a test suite based on the filename.
% Number of test cases to create.
n_test_cases = 100;
% Random integer: [0, 100].
random_integers = randi([0, 100], 1, n_test_cases);
fcn1(random_integers);
% Write the TestCase as an xml file with .m filename.
test_suite.xmlwrite(mfilename);
end

function fcn1(random_integers)
for idx = 1:numel(random_integers)
    random_integer = random_integers(idx);
    fcn2(random_integer, idx);
end
end

function fcn2(random_integer, idx)
global test_suite
% Create a test case.
test_case = junit.TestCase(sprintf('Test Case #%d', idx));
try
    assert(random_integer>25)
    test_case.stdout=sprintf('Test Success! %d', random_integer);
catch Error
    % Test was skipped.
    test_case.error(Error);
end
test_suite.append(test_case);
end
