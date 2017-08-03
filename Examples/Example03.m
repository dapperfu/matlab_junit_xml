%% Example 03
% Generate test cases and add them to a test suite in a loop.
ts = junit.TestSuite();
ts.name='Example 03';
for r = rand(1, 5)
    tc = junit.TestCase(matlab_ipsum('Sentences', 1, 'Paragraphs', 1, 'Words', 2, 'WordsStd', 1));
    tc.stdout = matlab_ipsum('Sentences', 2, 'Paragraphs', 1);
    tc.elapsed_sec=rand(1,1)*100+10;
    ts.append(tc); 
end

% Write the TestCase as an xml file with .m filename.
ts.xmlwrite(mfilename);
