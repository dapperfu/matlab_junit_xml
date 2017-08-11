function git_base = gitroot(varargin)
% GITROOT - SEARCH FOR GIT DIRECTORY
%  Recursively searches up or down a given path to find the base repository
%  directory (Containing the .git folder).
%
% Syntax:
%	git_base = gitroot(base_path, search_direction)
%
%   C:\Projects\.git          <- Git repo 1
%   C:\Projects\gitroot\.git  <- Git repo 2
%   C:\Projects\gitroot\tools <- Current working directory:
%
%   gitroot() returns C:\Projects\gitroot
%   gitroot(pwd, false) returns C:\Projects
%
% Inputs:
%	base_path - Base path to start searching on. Working directory if empty
%	search_direction - Selects the direction of the sort
%       true - results in starting at the base_path and working up.
%       false - results in starting at the root folder and working to base_path
%
% Outputs:
%	git_base - Base git repository.
%
% Example:
%	git_base = gitroot(base_path, search_direction)
%

% Author: Frey, Jed
% Email: mathworks+gitroot@exstatic.org
% August 2017

% If no base_path is given or it is empty.
if nargin<1 || isempty(varargin{1})
    % Set it to the empty
    varargin{1} = pwd;
end

% If direction is not given or it is not a logical.
if nargin<2 || ~islogical(varargin{2})
    % Set it to true (work up the path.).
    varargin{2} = true;
end

% Assign the variables from varargin
base = varargin{1};
direction = varargin{2};

% Split the base directory.
base_split = strsplit(base, '\');


% Create a loop based on the direction
if direction
    % Top level directory down.
    loop = numel(base_split):-1:1;
else
    % Bottom level directory up.
    loop = 1:numel(base_split);
end

% Loop through each of the paths.
for idx = loop
    % Create path to a possible git_folder.
    git_folder = fullfile(base_split{1:idx}, '.git');
    % If the folder exists.
    if exist(git_folder, 'dir')
        % Set the git_base to the path found containing a .git folder.
        git_base = fullfile(base_split{1:idx});
        return
    end  
end
% Raise an error if not in a git repository.
error('GITROOT:NOTFOUND', 'Current path is not in a git repository');
