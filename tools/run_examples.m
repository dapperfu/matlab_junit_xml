%% Run All Tests
cwd = fileparts(mfilename('fullpath'));

[~, junit_xml_path] = fileattrib(fullfile(cwd, '..'));
[~, junit_xml_examples] = fileattrib(fullfile(cwd, '..', 'Examples'));

addpath(junit_xml_path.Name);

% Get all files in this directory.
cd(junit_xml_examples.Name);
files = dir(junit_xml_examples.Name);

% For all of the files in this directory.
for idx = 1:numel(files)
    % Get the current file.
    file = files(idx);
    % If the filename starts with Example and ends with .m.
    if strncmp(file.name, 'Example', 7) && strcmpi(file.name(end-1:end), '.m')
        % Run it.
        fprintf('Running: %s\n', file.name);
        run(file.name);
        fprintf('Publishing: %s\n', file.name);
        publish(file.name);
    end
end
