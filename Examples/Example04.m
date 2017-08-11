%% Example 04
% Generate test cases and add them to a test suite in a loop.
test_suite = junit.TestSuite();
test_suite.name='Example 04';
% Determine test result randomly.
for r = rand(1, 10)
    test_case_name = matlab_ipsum('Sentences', 1, 'Paragraphs', 1, 'Words', 2, 'WordsStd', 1);
    test_case = junit.TestCase(test_case_name);
    % Filler messages.
    message = matlab_ipsum('Sentences', 1, 'Paragraphs', 1, 'Words', 2, 'WordsStd', 1);
    out = matlab_ipsum('Sentences', 2, 'Paragraphs', 1);
    if r<0.5 % Passes
        
    elseif r<0.6 % Failure
        test_case.failure(sprintf('Failure: %s!', message), sprintf('!! Error!!\n'));        
    elseif r<0.8 % Error
        test_case.error(sprintf('Error: %s!', message), sprintf('!! Error!!\n'));        
    else % Skipped
        test_case.skipped(sprintf('Skipped: %s!', message), sprintf('!! Error!!\n'));
    end
    % Random elapsed time.
    test_case.time=r*100+10;
    % Filler stdout.
    test_case.stdout = matlab_ipsum('Sentences', 2, 'Paragraphs', 1);
    test_suite.append(test_case); 
end
% Write the TestCase as an xml file with .m filename.
test_suite.xmlwrite(mfilename);
type([mfilename '.xml']);
