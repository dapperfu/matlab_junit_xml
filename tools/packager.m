function packager(root)
% PACKAGER - Package all files in a given root folder.
%   Searches for .prj folders in the root directory. Builds them into matlab
%   toolboxes. 
%
% Syntax:
%	packager(root)
%
% Inputs:
%	root - Root directory to build. 
%       Defaults to 'gitroot' if installed.
%                   'pwd' if gitroot is not installed.
%           
% Example:
%	packager()
%
% See also: 
%   gitroot

if nargin < 1
    % Find all packages in the repository root.
    if exist('gitroot', 'file')
        root = gitroot;
    else
        root = pwd;
    end
end

% Get all projects in the givev root directory.
projects = dir(fullfile(root, '*.prj'));

% For each project found.
for idx = 1:numel(projects)
    project = projects(idx);    
    bumpversion(project);
    % Print status update.
    fprintf('Packaging toolbox defined in %s ...', project.name);
    % Generate full path to project.
    if isfield(project, 'folder')
        proj = fullfile(project.folder, project.name);
    else
        proj = fullfile(root, project.name);
    end
    
    % The toolbox root is an absolute path. When using Jenkins this is
    % never always known. Start a new service and force root path to the
    % folder that contains the .prj.
    service = com.mathworks.toolbox_packaging.services.ToolboxPackagingService;
    % Open the project.
    proj_name = service.openProject(proj);
    % Remove the existing root.
    service.removeToolboxRoot(proj_name);
    % Add a new toolbox root.
    service.setToolboxRoot(proj_name, fileparts(proj))
    % Save the project.
    service.save(proj_name);
    % Close the project.
    service.closeProject(proj_name)
    
    % Package the toolbox.
    matlab.addons.toolbox.packageToolbox(proj);
    % Print status update.
    fprintf('... Done\n');
end
end
