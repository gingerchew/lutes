-- only use the runner in the context of describe
-- pass in the inner it function to save tests locally
local expect = require 'expect'
local symbols = require 'symbols'
local colors = require 'ansicolors'


local Describe = {}

function Describe:new(msg, desc_fn)
    self.__fns = {}

    desc_fn(function(test_msg, test_fn)
        self:store_fn(test_msg, test_fn)
    end, expect)
    
    local print_msg = self:run(msg)

    print(print_msg)
end

function Describe:store_fn(msg, it_fn)
    self.__fns[msg] = it_fn
end

function Describe:run(msg)
    local has_errors = false
    local msgs = ''

    for test_msg, test_fn in pairs(self.__fns) do
        local is_final = next(self.__fns, test_msg) == nil

        local status, err = pcall(test_fn, expect)

        if not status then
            has_errors = true
            msgs = msgs..'\n'..symbols:icon(is_final and 'entry_error_final' or 'entry_error')..test_msg..colors("%{red}%{bright} "..err)
        else
            msgs = msgs..'\n'..symbols:icon(is_final and 'entry_final' or 'entry')..test_msg..colors('%{green}%{bright} Passed')
        end
    end

    local print_msg = '\n'
    if has_errors then
        print_msg = print_msg..symbols:icon('error_start')..colors('%{bright}%{red}'..msg)..'\n'
    else
        print_msg = print_msg..symbols:icon('start')..colors('%{bright}%{green}'..msg)..'\n'
    end

    return print_msg..symbols:icon('wall')..msgs
end

-- Can this be done without making a huge concated string??
-- this function is doing a lot lmao
-- fix that
--[[local function describe(msg, desc_fn)
    -- cue all the tests here first
    local test_table = {}
    local function it(test_msg, test_fn)
        test_table[test_msg] = test_fn
    end
    -- prepare msgs var
    local msgs = ''
    local has_errors = false

    -- run tests passing in the cue-ing it function and expect
    desc_fn(it, expect)
    for test_msg, test_fn in pairs(test_table) do
        local is_final = next(test_table, test_msg) == nil
        local start_time = os.clock()
        -- to match functionality with `test.it` pass expect at this level again
        local status, err = pcall(test_fn, expect)
        -- need to format this better and make it not the responsibility of describe
        local dur = colors("%{dim}"..string.format("%.2f", (os.clock() - start_time) * 1000)..'ms ')
        if not status then
            has_errors = true
            msgs = msgs..'\n'..symbols:icon(is_final and 'entry_error_final' or 'entry_error')..dur..test_msg..' '..colors('%{red}%{bright}'..err)
        else
            msgs = msgs..'\n'..symbols:icon(is_final and 'entry_final' or 'entry')..dur..test_msg..' '..colors('%{green}%{bright}Passed')
        end
    end
    local print_msg = '\n'
    if has_errors then
        print_msg = print_msg..symbols:icon('error_start')..colors('%{bright}%{red}'..msg)..'\n'
    else
        print_msg = print_msg..symbols:icon('start')..colors('%{bright}%{green}'..msg)..'\n'
    end
    print_msg = print_msg..symbols:icon('wall')..msgs
    print(print_msg)
    print(symbols.space)
end]]

local function describe(msg, desc_fn)
    Describe:new(msg, desc_fn)
end

return describe