```lua
--> Loading Handler
local Handler = loadstring(game:HttpGet("https://github.com/sunkenball/Modules/blob/main/ErrorHandler/Handler.lua?raw=true"))()

--> Initialisation Of The Handler:
Handler.new()

--> Proof it logs errors:

task.spawn(function() --> Stop error from yielding thread to show stacking of errors
    error("hi")
end)

print(nil + 45)
```
