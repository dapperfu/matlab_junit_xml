function varargout=bumpversion(varargin)

%% Input Processing
% Check the number of input & outputs.
narginchk(0, 2);
nargoutchk(0, 1);
switch nargin
    % If nothing is given, set project & bump_type to empty.
    case 0
        toolboxProjectLocation = [];
        bump_type = getenv('BUMPVERSION');
    case 1
        % If the only argument isn't a valid bump type.
        if ~any(strcmpi(varargin{1}, {'major', 'minor', 'bug', 'build'}))
            % It defines a project.
            toolboxProjectLocation = varargin{1};
            % Bump type is empty.
            bump_type = getenv('BUMPVERSION');
        else
            % Otherwise, project is empty.
            toolboxProjectLocation = [];
            % And bump type is the sole argument.
            bump_type = varargin{1};
        end
    case 2
        % If both input
        toolboxProjectLocation = varargin{1};
        bump_type = varargin{2};
end

%% Input Validation
% If project is empty / not specified.
if isempty(toolboxProjectLocation)
    % Get all projects in the current directory.
    toolboxProjectLocation = dir(fullfile(pwd, '*.prj'));
    % If there is more than one project, throw an error.
    if len(toolboxProjectLocation)>1
        error('BUMPVER:TOOMANY', 'More than one project found in the current directory. Project must be explicitly defined')
    elseif len(toolboxProjectLocation)==0
        error('BUMPVER:TOOFEW', 'No project found in the current directory.')
    else
        % Otherwise use the project name as the project.
        if isfield(toolboxProjectLocation, 'folder')
            toolboxProjectLocation = fullfile(toolboxProjectLocation.folder, toolboxProjectLocation.name);
        else
            toolboxProjectLocation = fullfile(pwd, toolboxProjectLocation.name);
        end
    end
end
% Get the absolute path to the file in case it was input as a relative path
if isstruct(toolboxProjectLocation)
    toolboxProjectLocation = fullfile(toolboxProjectLocation.folder, toolboxProjectLocation.name);
elseif ischar(toolboxProjectLocation) && ~java.io.File(toolboxProjectLocation).isAbsolute
    toolboxProjectLocation = fullfile(pwd,toolboxProjectLocation);
else
    error('Unknown toolbox project location class: %s', class(toolboxProjectLocation));
end

% If bump_type is empty / not specified
if isempty(bump_type)
    % Default bump type is a build.
    bump_type = 'build';
end
%% Toolbox processing.
% Open the project and package it
try
    service = com.mathworks.toolbox_packaging.services.ToolboxPackagingService;
    configKey = service.openProject(toolboxProjectLocation);
    c = onCleanup(@()service.closeProject(configKey));
catch e
    error(message('MATLAB:toolbox_packaging:packaging:InvalidToolboxProjectFile',toolboxProjectLocation));
end

% Get the version value from the node, convert to Matlab string from
% Java String.
version_value = char(service.getVersion(configKey));
% Split the version string into major, minor, bug & build parts.
version_split = strsplit(version_value, '.');
% Convert each of those parts to an integer.
version_split_n = cellfun(@str2double, version_split);

% Required parts.
version_major = version_split_n(1);
version_minor = version_split_n(2);

% Optional Parts
if numel(version_split)>2
    % If bug_version is specified.
    version_bug   = version_split_n(3);
else
    % Otherwise set it to zero.
    version_bug = 0;
end
if numel(version_split)>3
    % If build version is specified, read it.
    version_build = version_split_n(4);
else
    % Otherwise set it to zero.
    version_build = 0;
end

% Switch based on the version bump type.
switch lower(bump_type)
    case 'major'
        % Major version bump.
        
        % Increment major version.
        version_major = version_major+1;
        % Set all other version integers to zero.
        version_minor = 0;
        version_bug = 0;
        version_build = 0;
    case 'minor'
        % Minor version bump.
        
        % Increment minor version number.
        version_minor = version_minor + 1;
        % Set all other version integers to zero.
        version_bug = 0;
        version_build = 0;
    case 'bug'
        % Bug version bump.
        
        % Increment bug version number.
        version_bug = version_bug + 1;
        % Set all other version integers to zero.
        version_build = 0;
    case 'build'
        % Build version bump.
        
        % Increment bug version number.
        version_build = version_build + 1;
end
% Convert the version integers back into a string.
version_new = sprintf('%d.%d.%d.%d', version_major, version_minor, version_bug, version_build);
% Set the version value node's value to the new version string.
service.setVersion(configKey, version_new)
% Write the new version back
service.save(configKey);

% If an output is specified, return the new version as a string.
if nargout == 0
    fprintf('Bumped %s to v%s\n', toolboxProjectLocation, version_new);
elseif nargout == 1
    varargout{1} = version_new;
end
