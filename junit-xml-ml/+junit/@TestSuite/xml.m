function test_suite_node = xml(self, docNode)
% If there is no parent testsuites node (no docNode passsed in)
% Generate a top level testsuites document;
if nargin<2
    docNode = com.mathworks.xml.XMLUtils.createDocument('testsuites');
    test_suites_node = docNode.getDocumentElement;
else
    test_suites_node = docNode.getDocumentElement;
end

test_suite_node = docNode.createElement('testsuite');

% Set calculated test suite attributes.
test_suite_node.setAttribute('tests', self.tests)
test_suite_node.setAttribute('failures', self.failures)
test_suite_node.setAttribute('errors', self.errors)
test_suite_node.setAttribute('skipped', self.skipped)

% Set calculated test suites attributes.
test_suites_node.setAttribute('time', self.elapsed_sec)
test_suites_node.setAttribute('tests', self.tests)
test_suites_node.setAttribute('failures', self.failures)
test_suites_node.setAttribute('errors', self.errors)
test_suites_node.setAttribute('skipped', self.skipped)

fields = fieldnames(self);
% For each of the object fields.
for idx = 1:numel(fields)
    % Pull out the field name from the field cell array based
    % on the loop index.
    field = fields{idx};
    
    % Don't put in empty fields.
    % Continue.
    if isempty(self.(field))
        continue;
    end
    
    if strcmpi(field, 'test_cases')
        continue;
    end
    
    % Get the value of the field.
    tmp_value = self.(field);
    % If it is numeric.
    if isnumeric(tmp_value)
        % Convert it to a string.
        value = num2str(tmp_value);
    else
        % If it is not, pass it through.
        value = tmp_value;
    end
    % Set the test attribute field with given value.
    test_suite_node.setAttribute(field, value)
end

% For each of the test cases.
for idx = 1:numel(self.test_cases)
    % Get the test case.
    test_case = self.test_cases(idx);
    % Get the test case node.
    test_case_node = test_case.xml(docNode);
    % Add it to the test suite.
    test_suite_node.appendChild(test_case_node);
end

if nargin<2
    % If no parent level testsuites node was passed in
    % Append the current node to the generated node
    % and return that.
    test_suites_node.appendChild(test_suite_node);
    test_suite_node = docNode;
end
end
