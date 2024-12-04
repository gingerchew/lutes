-- only use the runner in the context of describe
-- pass in the inner it function to save tests locally
local it_runner = require 'it'
local expect = require 'expect'
local symbols = require 'symbols'
local colors = require 'ansicolors'

-- Can this be done without making a huge concated string??
local function describe(msg, desc_fn)
    local test_table = {}
    local function it(test_msg, test_fn)
        test_table[test_msg] = test_fn
    end
    local msgs = ''
    local has_errors = false
    desc_fn(it, expect)
    for test_msg, test_fn in pairs(test_table) do
        local is_final = next(test_table, test_msg) == nil
        local status, err = pcall(test_fn, it_runner)

        if not status then
            has_errors = true
            msgs = msgs..'\n'..symbols:icon(is_final and 'entry_error_final' or 'entry_error')..test_msg..' '..colors('%{red}'..err)
        else
            msgs = msgs..'\n'..symbols:icon(is_final and 'entry_final' or 'entry')..test_msg..' '..colors('%{green}Passed')
        end
    end
    local print_msg = '\n'
    if has_errors then
        print_msg = print_msg..symbols:icon('error_start')..' '..msg..'\n'
    else
        print_msg = print_msg..symbols:icon('start')..' '..msg..'\n'
    end
    print_msg = print_msg..symbols:icon('wall')..msgs
    print(print_msg)
    print(symbols.space)
end

return describe