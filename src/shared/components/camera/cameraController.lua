local workspace = game:GetService("Workspace")

--[=[
@class CameraController
Provides an API to control camera effects.
@client
@unreleased

]=]
local CameraController = {}
CameraController.__index = CameraController

CameraController.camera = workspace.CurrentCamera
CameraController.effects = {}
CameraController.__inited = false

--[=[
Initializes the CameraController by setting up the current camera and loading effects.
@tag Setup

@return success -- Indicates if initialization was successful.
@return message -- Error message if initialization fails.
]=]
function CameraController:init()
    local success, message = pcall(function()
        self.camera = workspace.CurrentCamera
        for _, effect in ipairs(script.Parent.effects:GetChildren()) do
            local effectModule = require(effect)
            self.effects[effectModule.name] = effectModule
            effectModule:init(CameraController)
        end
    end)
    return success, message
end

--[=[
Sets attributes for a specified effect. Accepts either a key-value pair or a table of key-value pairs.
@tag Attribute

@param effectName string -- The name of the effect to modify.
@param keyOrTable string|table -- The attribute key or a table of key-value pairs.
@param value any -- The value to set for the specified key (ignored if keyOrTable is a table).
]=]
function CameraController:setAttribute(effectName, keyOrTable, value)
    local success : boolean, response : string = pcall(function()
        local effect = self.effects[effectName]

        if typeof(keyOrTable) == "string" then
            effect.Attributes[keyOrTable] = value
        elseif typeof(keyOrTable) == "table" then
            for key, val in pairs(keyOrTable) do
                effect.Attributes[key] = val
            end
        end
    end)

    if not success then warn(string.format("[%s] %s", "Camera Controller", response)) return end
end

--[=[
Retrieves the value of a specified attribute for a given effect. If no key is provided, returns all attributes.
@tag Attribute

@param effectName string -- The name of the effect to query.
@param key string? key -- The specific attribute key to retrieve (optional).
@return any -- The value of the specified attribute, or a table of all attributes if no key is provided.
]=]
function CameraController:getAttribute(effectName, key)
    local effect = self.effects[effectName]

    if not effect then
        return nil
    end

    if key then
        return effect.Attributes[key]
    end

    return effect.Attributes
end

return CameraController
