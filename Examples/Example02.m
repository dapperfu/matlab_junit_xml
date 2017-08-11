%% Example 02
% JUnit xml file generated from multiple tests.
% One of each status type.


test_case = junit.TestCase;

tc2 = junit.TestCase;
tc2.failure('Failure Message', 'Failure Output');

tc3 = junit.TestCase;
tc3.error('Error Message', 'Error Output');

tc4 = junit.TestCase;
tc4.skipped('Skipped Message', 'Skipped Output');

% Create test suite.
test_suite = junit.TestSuite;
test_suite.name = matlab_ipsum('Sentences', 1, 'Paragraphs', 1, 'Words', 2, 'WordsStd', 1);
% Add each of the test cases to the test suite.
test_suite.test_cases=[test_case, tc2, tc3, tc4];

%% Output
% Write the TestCase as an xml file with .m filename.
test_case.xmlwrite(mfilename);
type([mfilename '.xml']);
