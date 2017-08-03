function str = stackDump(stack)
%% STACKDUMP(stack) Dump a stack to a usable string.
%
%
%

% Create an empty string.
str = '';
% Loop through all of the elements in the stack.
for idx = 1:numel(stack)
    s = stack(idx);
    % Print the stack.
    str = sprintf('%sError in: %s (line %d)\n\t%s\n', str, s.name, s.line, s.file);
end
