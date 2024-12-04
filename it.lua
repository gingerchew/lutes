local expect = require 'expect'
local colors = require 'ansicolors'
local symbols = require 'symbols'
local function it(msg, test_fn)
    local status, err = pcall(test_fn, expect)
    print(symbols:icon('entry')..msg, status and colors'%{green}Passed' or '%{red}Failed', err or '')
end

return it