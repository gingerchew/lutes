local noop = function() end

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
            local is_same = v == value
            if not is_same then
                error("Value "..value.." did not match expected value "..v, 2)
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
            local error_msg = ''
            if type(value) == 'table' then
                for _,i in ipairs(value) do
                    if i == item then
                        passed = true
                    end
                end
                if not passed then
                    error_msg = 'Table '..value..' did not contain item '..item
                end
                return
            elseif type(value) == 'string' then
                local starti = value:find(item)
                if starti == nil then
                    error_msg = 'String "'..value..'" did not contain substring "'..item..'"'
                end
                return
            else
                error_msg = 'Value of type "'..type(value)..'" is not supported currently'
            end
            if not error_msg == '' then error(error_msg, 2) end
            -- Add more if it makes sense for other types
        end
    }
end

return expect