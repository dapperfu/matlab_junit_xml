function xmlwrite(self, filename)
[~, ~, ext] = fileparts(filename);
if ~strcmpi(ext, '.xml')
    filename = sprintf('%s.xml', filename);
end
% Write the test suite xml to a given file name.
xmlwrite(filename,self.xml);
end
