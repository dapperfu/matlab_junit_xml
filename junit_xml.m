docNode = com.mathworks.xml.XMLUtils.createDocument('testsuites');
docRootNode = docNode.getDocumentElement;


testsuite = docNode.createElement('testsuite'); 
testsuite.setAttribute('errors','0');
testsuite.setAttribute('failures','1');
testsuite.setAttribute('package','Simulink Model Advisor');
testsuite.setAttribute('tests','1');
testsuite.setAttribute('time','0.1');
testsuite.setAttribute('id','0');
testsuite.setAttribute('name','ts_name');

[id, hostname] = system('hostname');
testsuite.setAttribute('hostname', hostname);
testsuite.setAttribute('timestamp',strrep(datestr(now, 31), ' ', 'T'));

% properties = docNode.createElement('properties'); 
% property = docNode.createElement('property'); 
% property.setAttribute('name', 'java.vendor'); 
% property.setAttribute('value', 'Sun MicroSystems Inc.');
% properties.appendChild(property)
% testsuite.appendChild(properties)

testcase = docNode.createElement('testcase'); 
testcase.setAttribute('classname', 'ExampleTest');
testcase.setAttribute('name', 'testOne');
testcase.setAttribute('time', '0.1');
if true
    failure = docNode.createElement('failure');
    failure.setAttribute('type', 'VerificationFailure');
    failure.appendChild(docNode.createTextNode('Failure Reason'));
end
testcase.appendChild(failure);

sysout = docNode.createElement('system-out');
sysout.appendChild(docNode.createTextNode(''));
testcase.appendChild(sysout)

syserr = docNode.createElement('system-err'); 
syserr.appendChild(docNode.createTextNode(''));
testcase.appendChild(syserr)

testsuite.appendChild(testcase);
docRootNode.appendChild(testsuite);

xmlFileName = [tempname,'.xml'];
xmlwrite(xmlFileName,docNode);
type(xmlFileName);
