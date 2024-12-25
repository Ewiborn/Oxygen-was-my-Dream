--[=[
@class Controls
Provides an API to manage control profiles, allowing customization of key bindings for various actions.
@client

]=]
local Controls = {}
Controls.__index = Controls

--[=[
Creates a new instance of the Controls class with default key bindings.

@return Controls -- A new instance of the Controls class.
]=]
function Controls.new()
    local self = setmetatable({
        EmoteWheel = Enum.KeyCode.V, 
        Knockback = Enum.KeyCode.R,  
        Roll = Enum.KeyCode.LeftShift, 
        Interact = Enum.KeyCode.F    
    }, Controls)

    return self
end

return Controls
