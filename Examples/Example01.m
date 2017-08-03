%% Example 01
% Minimal xml file generated from a single test case.

% Create test case object.
test_case = junit.TestCase;
% Generate a standard out
test_case.stdout = matlab_ipsum;
% Write the TestCase as an xml file with .m filename.
test_case.xmlwrite(mfilename);
