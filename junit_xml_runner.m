tc = junit.TestCase;
tc.classname = 'some.class.name';
tc.name = 'Test1';
tc.elapsed_sec = '123.345';
tc.stdout = 'I am stdout!';
tc.stderr = 'I am stderr!';

ts = junit.TestSuite;
ts.name = 'my test suite';
ts.test_cases=[tc];

ts.xmlwrite('x.xml');
