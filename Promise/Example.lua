(function()
    getgenv().Promise = {}
    do
        Promise.__load = function(Path): func
            return loadstring(game:HttpGet("https://raw.githubusercontent.com/sunkenball/Modules" .. Path))
        end
        Promise.__new = function()
            local Library =  Promise.__load("/main/Promise.lua")
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
