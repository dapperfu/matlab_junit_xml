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

Forthcoming.