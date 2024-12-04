local noop = function() end

--[[
    This set up works for now
    but we're going to run into issues when 
    implementing `.not.{expect api}` functionality

    Rest of expect api to be implemented here [https://vitest.dev/api/expect.html#tocontain]
]]

local todo_prox = {}
function todo_prox.__newindex()
    return noop
end
function todo_prox.__index()
    return noop
end

local function expect(value)
    return {
        todo = todo_prox,
        toBe = function(v)
            if not (v == value) then
                error('Value mismatch', 2)
            end
        end,
        toBeDefined = function()
            if value == nil then
                error('Value was not defined or was nil',2)
            end
        end,
        toBeUndefined = function()
            if not value == nil then
                error('Value was defined',2)
            end
        end,
        toBeTruthy = function()
            if not value then
                error('Value was found to be falsy',2)
            end
        end,
        toBeFalsy = function()
            if value then
                error('Value was found to be truthy',2)
            end
        end,
        toBeType = function(t)
            local found_type = type(value)
            if not found_type == t then
                error("Value was expected to be type "..t.." but found type "..found_type,2)
            end
        end,
        toBeGreaterThan = function(gt)
            if value <= gt then
                error("Value "..value.." was found to be less than or equal to "..gt,2)
            end
        end,
        toBeGreaterThanOrEqual = function(gte)
            if value < gte then
                error("Value "..value.." was found to be less than "..gte,2)
            end
        end,
        toBeLessThan = function(lt)
            if value >= lt then
                error('Value '..value..' was found to be greater than or equal to '..lt,2)
            end
        end,
        toBeLessThanOrEqual = function(lte)
            if value > lte then
                error('Value '..value..' was found to be greater than '..lte,2)
            end
        end,
        toEqual = function(v)
            -- To be implemented
        end,
        toContain = function(item)
            local passed = false
            if type(value) == 'table' then
                for _,i in ipairs(value) do
                    if i == item then
                        passed = true
                    end
                end
                if not passed then
                    error('Table did not contain item '..item, 2)
                end
            elseif type(value) == 'string' then
                local starti = value:find(item)

                if starti == nil then
                    error('String "'..value..'" did not contain substring "'..item..'"', 2)
                end
            -- else
            --     error_msg = 'Value of type "'..type(value)..'" is not supported currently'
            -- Add more if it makes sense for other types
            end
        end,
        toContainEqual = function()
            -- To be implemented
            -- semi-relies on toEqual
        end,
        toHaveLength = function(len)
            local t = type(value)
            if t == 'string' then
                if not (string.len(value) == len) then
                    error('String '..value..' was longer than expected value ('..len..')', 2)
                end
            elseif t == "table" then
                local count = 0
                for _ in pairs(value) do count = count + 1 end

                if not count == len then
                    error('Table was larger than expected size ('..len..')', 2)
                end
            end
        end,
        -- based on https://snippets.bentasker.co.uk/posts/lua/check-if-value-exists-in-table.html
        toHaveProperty = function(key)
            local found = false
            for k,_ in pairs(value) do
                if k == key then
                    found = true
                end
            end
            if not found then error('Could not find key "'..key..'" in table', 2) end
        end,
        toMatch = function(pattern)
            local found = string.match(value, pattern)
            if found == nil then
                error('Value "'..value..'" did not match with pattern "'..pattern..'"', 2)
            end
        end,
        toMatchObject = function()
            -- to be implemented
            -- this is in depth seeming
            -- probably hold off for now
        end,
        toThrowError = function ()
            -- to be implemented
            -- not sure how this will work with
            -- pcall and the general way
            -- that lua handles errors
        end,
        -- snapshot testing likely not useful

    }
end

return expect