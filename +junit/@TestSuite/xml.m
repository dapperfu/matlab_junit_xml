function node = xml(self, docNode)
% If there is no parent testsuites node (no docNode passsed in)
% Generate a top level testsuites document;
if nargin<2
    docNode = com.mathworks.xml.XMLUtils.createDocument('testsuites');
    docRootNode = docNode.getDocumentElement;
end

node = docNode.createElement('testsuite');
% Set calculated test suite attributes.
node.setAttribute('time', self.elapsed_sec)
node.setAttribute('tests', self.tests)
node.setAttribute('failures', self.failures)
node.setAttribute('errors', self.errors)
node.setAttribute('skipped', self.skipped)

% For each of the test cases.
for idx = 1:numel(self.test_cases)
    % Get the test case.
    test_case = self.test_cases(idx);
    % Get the test case node.
    test_case_node = test_case.xml(docNode);
    % Add it to the test suite.
    node.appendChild(test_case_node);
end

if nargin<2
    % If no parent level testsuites node was passed in
    % Append the current node to the generated node
    % and return that.
    docRootNode.appendChild(node);
    node = docNode;
end
end
