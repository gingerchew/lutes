-- only use the runner in the context of describe
-- pass in the inner it function to save tests locally
local expect = require 'expect'
local symbols = require 'symbols'
local colors = require 'ansicolors'


local Describe = {}

function Describe:new(msg, desc_fn)
    self.__fns = {}
    self.has_errors = false
    
    desc_fn(function(test_msg, test_fn)
        self.__fns[test_msg] = test_fn
    end, expect)

    local print_msg = self:test(msg)
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

function Describe:run(test_msg, test_fn)
    local is_final = next(self.__fns, test_msg) == nil
    local get_dur = self:dur()
    local status, err = pcall(test_fn, expect)
    local dur = get_dur()

    if not status then
        self.has_errors = true

        coroutine.yield(test_msg, '\n'..symbols:icon(is_final and 'entry_error_final' or 'entry_error')..dur..test_msg..colors("%{red}%{bright} "..err))
    else
        coroutine.yield(test_msg, '\n'..symbols:icon(is_final and 'entry_final' or 'entry')..dur..test_msg..colors("%{green}%{bright} Passed"))
    end
end

function Describe:test(msg)
    local msgs = ''

    -- Create coroutine
    -- yielding inside of :run will propagate
    local co = coroutine.create(function ()
        for test_msg, test_fn in pairs(self.__fns) do
            self:run(test_msg, test_fn)
        end
    end)

    -- get the first index of the loop and
    -- then while through the self.__fns table
    local index = next(self.__fns);
    while not (index == nil) do
        local _, prev_index, result_msg = coroutine.resume(co)
        msgs = msgs..result_msg
        index = next(self.__fns, prev_index)
    end

    -- string formatting like this sucks
    local print_msg = '\n'
    if self.has_errors then
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