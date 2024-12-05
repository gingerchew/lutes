-- only use the runner in the context of describe
-- pass in the inner it function to save tests locally
local expect = require 'expect'
local symbols = require 'symbols'
local colors = require 'ansicolors'


local Describe = {}

function Describe:new(msg, desc_fn)
    self.__fns = {}

    desc_fn(function(test_msg, test_fn)
        self.__fns[test_msg] = test_fn
    end, expect)
    -- messing with coroutines
    -- is this useful? is this good? to be seen
    -- I could see it being more useful inside of :run
    local co = coroutine.create(function()
        local print_msg = self:run(msg)
        coroutine.yield(print_msg)
    end)

    local _, print_msg = coroutine.resume(co)

    print(print_msg)
end

-- Simple duration passed function
---@TODO: Format the string better
function Describe:dur()
    local start_time = os.clock()

    return function()
        return colors("%{dim}"..string.format("%.2f", (os.clock() - start_time) * 1000)..'ms ')
    end
end

function Describe:run(msg)
    local has_errors = false
    local msgs = ''

    -- maybe this could be moved into a coroutine?
    for test_msg, test_fn in pairs(self.__fns) do
        local is_final = next(self.__fns, test_msg) == nil
        local get_dur = self:dur()
        local status, err = pcall(test_fn, expect)


        if not status then
            has_errors = true
            msgs = msgs..'\n'..symbols:icon(is_final and 'entry_error_final' or 'entry_error')..get_dur()..test_msg..colors("%{red}%{bright} "..err)
        else
            msgs = msgs..'\n'..symbols:icon(is_final and 'entry_final' or 'entry')..get_dur()..test_msg..colors('%{green}%{bright} Passed')
        end
    end

    -- string formatting like this sucks
    local print_msg = '\n'
    if has_errors then
        print_msg = print_msg..symbols:icon('error_start')..colors('%{bright}%{red}'..msg)..'\n'
    else
        print_msg = print_msg..symbols:icon('start')..colors('%{bright}%{green}'..msg)..'\n'
    end

    return print_msg..symbols:icon('wall')..msgs
end

local function describe(msg, desc_fn)
    Describe:new(msg, desc_fn)
end

return describe