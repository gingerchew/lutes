local test = require('main')

test.describe('@lutest/test', function (it, expect)
    it('should have defined methods it, expect, and describe', function()
        expect(test.expect).toBeDefined()
        expect(test.it).toBeDefined()
        expect(test.expect).toBeType('function')
        expect(test.it).toBeType('function')
        expect(test.describe).toBeType('function')
    end)
end)

test.describe('@lutest/describe', function (it, expect)
    it('should pass it and expect to the callback function', function ()
        expect(expect).toBeType('function')
        expect(it).toBeType('function')
    end)

    it('should fail', function()
        expect(0).toBe(1)
    end)
end)

