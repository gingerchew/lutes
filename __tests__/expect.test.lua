local test = require('main')

-- uncomment to make sure it fails properly
--test.expect(1).toBe(3)

test.it('should run individual tests', function (expect)
    expect(1).toBe(1)
end)

test.describe('@lutes/mod', function (it, expect)
    it('should pass', function ()
        expect(1).toBe(1)
    end)
    it('should pass again', function ()
        expect(1).toBe(1)
    end)
end)


test.describe('@lutes/describe', function (it, expect)
    it('should pass it and expect to the callback function', function ()
        expect(expect).toBeType('function')
        expect(it).toBeType('function')
    end)

    it('should fail', function()
        expect(0).toBe(1)
    end)
end)

test.describe('@lutes/expect', function(it, expect)
    it('should be defined', function()
        expect(1).toBeDefined()
    end)
    it('should be undefined', function ()
        expect(nil).toBeUndefined()
    end)
    it('should handle length', function()
        expect('123').toHaveLength(3)
        expect({1,2,3}).toHaveLength(3)
    end)
    it('should fail length', function()
        expect('123').toHaveLength(2)
        expect({1,2,3}).toHaveLength(2)
    end)

    it('should handle contains', function()
        expect('123').toContain('2')
        expect({1,2,3}).toContain(2)
    end)
    it('should fail contains',  function ()
        expect('123').toContain('1234')
        expect({1,2,3}).toContain('1')
    end)
    it('should find keys in tables', function ()
        expect({ name = 'John' }).toHaveProperty('name')
        expect({ 123 }).toHaveProperty(1)
    end)
    it('should fail to find keys in tables', function ()
        expect({ name = 'John' }).toHaveProperty('age')
        expect({ 123 }).toHaveProperty('name')
    end)
    it('should match strings', function ()
        expect('John').toMatch('John')
        expect('alsdkjfasldfjahsdlfakjhsdfalkjhdf').toMatch('ldfjahsdlfakjh')
    end)
    it('should fail to match strings', function ()
        expect('John').toMatch('Jane')
    end)
end)


test.describe('@lutes/test', function (it, expect)
    it('should have defined methods it, expect, and describe', function()
        expect(test.expect).toBeDefined()
        expect(test.it).toBeDefined()
        expect(test.expect).toBeType('function')
        expect(test.it).toBeType('function')
        expect(test.describe).toBeType('function')
    end)
    -- this fails, is this because even though the module passed is the same
    -- it registers as something different when comparing with ==
    -- `it` currently is different when using the it in describe
    it('should pass the same expect as arguments', function (expect2)
        expect(test.expect).toBe(expect)
        expect(expect).toBe(expect2)
    end)

    it('should run for a while to test the time formatting', function ()
        -- should run for 3-4ms
        for i = 1, 1000000, 1 do end
        expect(1).toBe(1)
    end)

    it('should run for _a while_', function ()
        for i = 1, 1000000, 1 do
            for j = 1, 100, 1 do
                
            end
        end
        expect(1).toBe(1)
    end)
end)