export type Effects = { [string]: Effect }

export type Effect = {
    name: string,
    Attributes: {
        MaxSwayAngle: number,
        SwaySpeed: number,
        BalanceAmplitude: number,
        BalanceSpeed: number,
        Intensity: number,
    },
    init: (self: Effect, Parameters: { CameraController: any }) -> (),
}

export type CameraController = {
    camera: Camera,
    effects: Effects,
    __inited: boolean,
    init: (self: CameraController) -> (boolean, string?),
    setAttribute: (self: CameraController, effectName: string, keyOrTable: string | { [string]: any }, value: any?) -> (),
    getAttribute: (self: CameraController, effectName: string, key: string?) -> any,
}

local CameraController: CameraController = {
    camera = workspace.CurrentCamera,
    effects = {},
    __inited = false,

    init = function(self)
        local success, message = pcall(function()
            self.camera = workspace.CurrentCamera
            for _, effect in ipairs(script.Parent.effects:GetChildren()) do
                local effectModule = require(effect)
                self.effects[effectModule.name] = effectModule
            end
        end)
        return success, message
    end,

    setAttribute = function(self, effectName, keyOrTable, value : any?)
        local effect = self.effects[effectName]
        if not effect then
            error("Effect not found: " .. effectName)
        end
        if typeof(keyOrTable) == "string" then
            effect.Attributes[keyOrTable] = value
        elseif typeof(keyOrTable) == "table" then
            for key, val in pairs(keyOrTable) do
                effect.Attributes[key] = val
            end
        else
            error("Invalid arguments for setAttribute")
        end
    end,

    getAttribute = function(self, effectName, key)
        local effect = self.effects[effectName]
        if not effect then
            return nil
        end
        if key then
            return effect.Attributes[key]
        end
        return effect.Attributes
    end,
}

return {
    CameraController = CameraController,
}
