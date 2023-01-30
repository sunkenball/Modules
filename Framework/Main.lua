--> Framework
local Framework                = {}

--> Internal Variables

Framework.Version              = "1.0A"
Framework.Start                = tick()
Framework.Loaded               = false
Framework.Protected            = false
Framework.Debug                = false

--> <> Function Storing
Framework.UnloadedFunctions    = {}
Framework.LoadedFunctions      = {}
Framework.ProtectedFunctions   = {}
Framework.Functions            = {}

--> <> Easy Fetching Of Services
Framework.Services             = setmetatable({}, {__index = function(self, index)
    return game:GetService(index)
end})

--> <> Modules

Framework.Modules              = {}

--> <> Modules -> Debug

Framework.Modules.Debug = {
    Print = function(...)
        if not Framework.Debug then
            return
        end
        print(string.format("[FW %s]: ", Framework.Version) .. ...)
    end,
    Warn  = function(...)
        if not Framework.Debug then
            return
        end
        warn(string.format("[FW %s]: ", Framework.Version) .. ...)
    end,
    Error = function(...)
        if not Framework.Debug then
            return
        end
        error(string.format("[FW %s]: ", Framework.Version) .. ..., 0)
    end,
}

--> <> Modules -> Promise

(function()
    getgenv().Promise = {}
    do
        Promise.__load = function(Path)
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

Framework.Modules.Promise = Promise.__new()

--> Functions

--> <> Modules

function Framework:GetModule(...)
    return self.Modules[...]
end

--> <> Function Initialisation

function Framework:AddFunction(name, callback)
    --> <> Type Checking
    assert(type(name)               ==     "string"     ,   "`name` must be string")
    assert(string.len(name)         >=     0            ,   "`name` must be longer than 0 characters")
    assert(type(callback)           ==     "function"   ,   "`callback` must be function")

    --> Proceeding To Implement Functions Into @self

    local hasMetatable = getmetatable(self)
    --> Checking if the table has a metatable, so we can alter how we input the functions to bypass any metamethods which are put in place on the table
    if hasMetatable then
        rawset(self.UnloadedFunctions, name, callback)
    else
        self.UnloadedFunctions[name] = callback
    end
end

function Framework:CallFunction(name, ...)
    assert(type(name)         ==    "string"    , "`name` must be string")
    assert(string.len(name)   >=    0           , "`name` must be longer than 0 characters")

    self.LoadedFunctions[name](...)
end

function Framework:ProtectFunctions()
    local Debug = self:GetModule("Debug")
    for i,v in next, self.UnloadedFunctions do
        --> No need to check type as we check before inputting then into table
        if not table.find(self.ProtectedFunctions, v) then
            local Success, Output = pcall(function()
                local old; old = hookfunction(v, function(...)
                    if not checkcaller() then
                        return
                    end
                    return old(...)
                end)
            end)
            if Success then
                table.insert(self.ProtectedFunctions, v)
                Debug.Print("Protected Function: " .. i)
            else
                return
            end
        end
    end
    self.Protected = true
end

function Framework:Load()
    local Debug = Framework:GetModule("Debug")
    local Print = Debug.Print
    if self.Loaded then
        return Print("Framework is already loaded")
    end
    local Success, Output = pcall(function()
        --> One last check before initialising functions and inputting into loaded list
        --> i -> Name, v -> Callback | Function
        for i,v in next, self.UnloadedFunctions do
            if type(v) == "function" then
                self.LoadedFunctions[i] = v
                Print("Loaded Function: " .. i)
            end
        end
    end)
    local HowsItGo = Success and "✅" or not Success and "❌"
    self.Loaded = true
    Print(string.format("Loaded FW : %s : %sms", HowsItGo, tostring(math.round((tick() - self.Start) * 1000))))
end

function Framework:Debug(...)
    assert(type(...) == "boolean", "`...` must be a boolean")
    self.Debug = ...
end

return Framework
