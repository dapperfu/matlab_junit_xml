clc
delete('*.xml');

tc = junit.TestCase;
tc.classname = 'some.class.name';
tc.name = 'Test 1';
tc.elapsed_sec = '1';
tc.stdout = 'I am stdout!';
tc.stderr = 'I am stderr!';
tc.error('Error Message', 'Error Output');

tc2 = junit.TestCase;
tc2.classname = 'some.class.name';
tc2.name = 'Test 2';
tc2.elapsed_sec = 2;
tc2.stdout = 'I am stdout 2!';
tc2.stderr = 'I am stderr 2!';
tc2.failure('Failure Message', 'Failure Output');

tc3 = junit.TestCase;
tc3.skipped('Skipped Message', 'Skipped output');
tc3.elapsed_sec = 0;

ts = junit.TestSuite;
ts.name = 'my test suite';
ts.test_cases=[tc, tc2];

ts.xmlwrite('test.xml');
