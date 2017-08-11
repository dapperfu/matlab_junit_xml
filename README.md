# junit-xml-ml

Creates JUnit XML test result documents that can be read by tools such as Jenkins. Aims to be the Matlab equivalent of [junit-xml for Python](https://pypi.python.org/pypi/junit-xml).

A Matlab class for creating JUnit XML test result documents that can be read by tools such as Jenkins. If you are ever working with test tool or test suite written in Matlab and want to take advantage of Jenkins’ pretty graphs and test reporting capabilities, this module will let you generate the XML test reports.

Matlab R2015b does include [matlab.unittest.plugins.XMLPlugin class](https://www.mathworks.com/help/matlab/ref/matlab.unittest.plugins.xmlplugin-class.html) that writes test results to a file in XML format. The difficulty with the using the unittest framework is that your code must be structured as a test.

This makes it difficult to shoehorn into legacy code bases I've inherited.

## Project Motivation:

- Manager: Here's a code base, you get to run it now. The individual that wrote it has moved on.
- "Can I have [Jenkins](https://jenkins.io/) run it?"
- Manager: As long as the results are the same and it's right.

# Examples

- [Example 01](https://htmlpreview.github.io/?https://github.com/jed-frey/matlab_junit_xml/blob/master/Examples/html/Example01.html)
  Minimal xml file generated from a single test case.

- [Example 02](https://htmlpreview.github.io/?https://github.com/jed-frey/matlab_junit_xml/blob/master/Examples/html/Example02.html)
  JUnit xml file generated from multiple tests. One of each status type.

- [Example 03](https://htmlpreview.github.io/?https://github.com/jed-frey/matlab_junit_xml/blob/master/Examples/html/Example03.html)
  Generate test cases and add them to a test suite in a loop.

- [Example 04](https://htmlpreview.github.io/?https://github.com/jed-frey/matlab_junit_xml/blob/master/Examples/html/Example04.html)
  Generate test cases and add them to a test suite in a loop. Pass, fail, error and skip tests based on randomly generated number.

- [Example 10](https://htmlpreview.github.io/?https://github.com/jed-frey/matlab_junit_xml/blob/master/Examples/html/Example10.html)
  Full 'real world' example with passing, skipping & errors.

- [Example 11](https://htmlpreview.github.io/?https://github.com/jed-frey/matlab_junit_xml/blob/master/Examples/html/Example11.html)
  Full 'real world' example with only errors.

- [Example 12](https://htmlpreview.github.io/?https://github.com/jed-frey/matlab_junit_xml/blob/master/Examples/html/Example12.html)
  Tested functions to get stack.

- [Example 13](https://htmlpreview.github.io/?https://github.com/jed-frey/matlab_junit_xml/blob/master/Examples/html/Example13.html)
  ~~Ab~~Using globals to keep track of test cases.

[See Examples folder for ```.m``` source code.](https://github.com/jed-frey/matlab_junit_xml/tree/master/Examples).
