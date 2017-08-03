%% Run All Tests
% Change to the directory of this .m-script.
cwd = fileparts(mfilename('fullpath'));
% Change to this directory to not scatter .xml files everywhere.
lwd = cd(cwd);

% Get all files in this directory.
files = dir(cwd);
% For all of the files in this directory.
for idx = 1:numel(files)
    % Get the current file.
    file = files(idx);
    % If the filename starts with Example and ends with .m.
    if strncmp(file.name, 'Example', 7) && strcmpi(file.name(end-2), '.m')
        % Run it.
        run(file.name);
    end
end

% Return from whence you came.
cd(lwd);
