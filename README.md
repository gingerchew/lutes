# Lutes

A `vitest`-like testing library for Lua

## How it works

First, require the `test` module like this:

```lua
local test = require 'test'
```

The `test` module has 3 parts to it.

### `test.expect`

This is how you check certain values:

```lua
test.expect(0).toBeFalsy() -- doesn't throw

test.expect(1).toBeFalsy() -- throws an error
```

### `test.it`

This is how most tests are started.

```lua
test.it('should throw an error', function()
    test.expect(0).toBe(1)
end)
```

When using `test.it` you can use `test.expect` as the first argument of the callback.

```lua
test.it('should be the same', function(expect)
    expect(1).toBe(1)
end)
```

### `test.describe`

For an extra layer of nice formatting (a la `vitest`) use `test.describe`. Both `test.it` and `test.expect` are passed as parameters for the callback function:

```lua
-- a contrived and fictional module that saves a value
local myMod = require 'my-library/my-module'

test.describe('@my-library/my-module', function(it, expect)
    local mine = myMod()
    it('should know x from y', function()
        mine.save(0)
        expect(mine.value).toBe(mine.value)
    end)

    it('should fail this test', function()
        expect(0).toBe(1) -- will fail
    end)
end)
```

## How did this happen?

Lua has been in my periphery for a while now. But whenever I tried to use it, I bumped up against some weird quirk of the language. Coming from Web Development, it is bizarre to me that there isn't a simple built in way to make a request to a server, but that's neither here nor there. In an attempt to learn more, I started Advent of Code and was determined to do it all in Lua.

As the days waned on though, the problems got harder and harder. I decided to go back to earlier AoC's and try them instead. They were easier, but I still felt like I wasn't able to get the expected result. I thought to myself:

> If only I could use `vitest` in Lua

Which I'm sure someone will figure out. Instead, I wrote a skeleton like script that implemented *most* of what I wanted from `vitest` and that helped me through the next couple challenges.

## Where's my `.to`

For the uninitiated, `vitest` supports these two syntaxes:

```js
expect(varA).to.be(varC)
expect(varA).toBe(varC)
```

For personal preference reasons, lutes uses the second version. If there's enough of a call for the first, I'm happy to look at a PR.

## What about...

I am still new to Lua development, I'm sure there are several battle tested solutions that are the standard that I could have reached for instead. This was a learning experience though. Like figuring out how to do colors in the terminal (thanks [ansicolors](https://github.com/kikito/ansicolors.lua)) or how error handling works.

### You're saying I shouldn't use this?

I'm saying unless you want to help buff out any rough spots, you probably want to use the battle tested solutions first. If you like the polish and nice things inside of `lutes` and want to help improve it further, I'm happy to look over issues or PRs.

## How can I help?

Here are some short term goals:

- [ ] Offer a single file/binary that folks can use instead of adding this repo to their deps
- [ ] Finish adding support for the rest of `expect` functionality from `vitest`
- [ ] Is there a better way to handle the message creation than string concat??
- [ ] `assert`?
- [ ] Assess best practices for Lua code writing and other such nonsense and buzz words