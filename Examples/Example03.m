%% Example 03
% Generate test cases and add them to a test suite in a loop.
test_suite = junit.TestSuite();
test_suite.name='Example 03';
for r = rand(1, 5)
    test_case = junit.TestCase(matlab_ipsum('Sentences', 1, 'Paragraphs', 1, 'Words', 2, 'WordsStd', 1));
    test_case.stdout = matlab_ipsum('Sentences', 2, 'Paragraphs', 1);
    test_case.elapsed_sec=rand(1,1)*100+10;
    test_suite.append(test_case); 
end

% Write the TestCase as an xml file with .m filename.
test_suite.xmlwrite(mfilename);
