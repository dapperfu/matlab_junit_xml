%% Example 04
% Generate test cases and add them to a test suite in a loop.
ts = junit.TestSuite();
ts.name='Example 04';
% Determine test result randomly.
for r = rand(1, 10)
    test_case_name = matlab_ipsum('Sentences', 1, 'Paragraphs', 1, 'Words', 2, 'WordsStd', 1);
    tc = junit.TestCase(test_case_name);
    % Filler messages.
    message = matlab_ipsum('Sentences', 1, 'Paragraphs', 1, 'Words', 2, 'WordsStd', 1);
    out = matlab_ipsum('Sentences', 2, 'Paragraphs', 1);
    if r<0.5 % Passes
        
    elseif r<0.6 % Failure
        tc.failure(sprintf('Failure: %s!', message), sprintf('!! Error!!\n'));        
    elseif r<0.8 % Error
        tc.error(sprintf('Error: %s!', message), sprintf('!! Error!!\n'));        
    else % Skipped
        tc.skipped(sprintf('Skipped: %s!', message), sprintf('!! Error!!\n'));
    end
    % Random elapsed time.
    tc.elapsed_sec=r*100+10;
    % Filler stdout.
    tc.stdout = matlab_ipsum('Sentences', 2, 'Paragraphs', 1);
    ts.append(tc); 
end
% Write the TestCase as an xml file with .m filename.
ts.xmlwrite(mfilename);
