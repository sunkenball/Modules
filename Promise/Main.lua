local Promise = {}

function Promise.new(func: func): table | string
    local Success, Output    = pcall(func)
    if not Success then
        return Promise, Output
    else
        return Promise
    end
end

function Promise:andThen(func: func): table | string
    local Success, Output    = pcall(func)
    if not Success then
        Promise:catch(warn, Output)
        return Promise, Output
    else
        return Promise
    end
end

function Promise:catch(func): table
    return Promise
end

function Promise.all(functions: table): boolean
    local NotSuccessful = {}
    for i,v in next, functions do
        if type(v) == "function" then
            local Success, Output = pcall(v)
            if not Success then
                local Line    =     Output:match(":(%d*):")
                local Error   =     Output:split(":")[3]:sub(2, -1)
                table.insert(NotSuccessful, string.format("Error At (%s): %s", tostring(Line), Error))
            end
        end
    end
    local Successful   =    not (#NotSuccessful > 0)
    local Errors       =    NotSuccessful
    return Successful, Errors
end

return Promise
