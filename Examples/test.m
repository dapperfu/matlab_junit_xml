function test
    test2('%d', 10);
    test2('hello');
end

function test2(x,varargin)
    msg = sprintf(x, varargin{:});
    fprintf('%s\n', msg);
end
