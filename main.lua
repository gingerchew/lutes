local it = require 'it'
local expect = require 'expect'
local describe = require 'describe'

local test = {}

function test.it(...)
    return it(...)
end
function test.expect(...)
    return expect(...)
end
function test.describe(...)
    return describe(...)
end

return test