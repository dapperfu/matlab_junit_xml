cwd = fileparts(mfilename('fullpath'));
lwd = cd(cwd);

files = dir(cwd);
for idx = 1:numel(files)-2
   file = files(idx);
    if strncmp(file.name, 'Example', 7)
        run(file.name);
    end
end

cd(lwd);
