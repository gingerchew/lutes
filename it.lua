local expect = require 'expect'
local colors = require 'ansicolors'
local symbols = require 'symbols'

local function it(msg, test_fn)
    local status, err = pcall(test_fn, expect)
    print(symbols:icon('entry_final')..msg, status and colors'%{bright}%{green}Passed' or '%{bright}%{red}Failed', err or '')
end

-- a noop method for tests that haven't been implemented yet
-- function it.skip(msg)
--     print(colors"%{dim}"..msg)
-- end

return it