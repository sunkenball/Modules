```lua
(function()
    getgenv().Promise = {}
    do
        Promise.__load = function(Path): func
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/sunkenball/Modules/main/Promise" .. Path))
        end
        Promise.__new = function()
            local Library =  Promise.__load("/Main.lua")
            if Library then
                return Library()
            end
        end
        Promise.__index = function(self, index)
            return rawget(self, index)
        end
        setmetatable(Promise, {__index = Promise})
    end
end)()

local Promise = Promise.__new()

Promise.new(function()
    print("Hi")
end):andThen(function()
    print("Hi 2")
end):catch(warn)

--> Runs all functions in a table, via a pcall to check if any errors, then feedbacks
local Success, Errors = Promise.all({
    function()
        print("hi")
    end,
    function()
        print("hi" + 45)
    end
})

if not Success then
    table.foreach(Errors, print)
else
    print("Successful")
end
```
