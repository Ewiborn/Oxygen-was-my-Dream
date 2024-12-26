local RunService = game:GetService("RunService")

--[=[
    @class Shake

    Contains API to control camera effects
]=]
local Shake = {}

-- Documenting the Attributes property
--[=[
    @prop Attributes table
    @within Shake
    A table containing the following fields:

]=]
Shake.Attributes = {

}

--[=[
    Initializes the Balance effect by binding it to the render step.

    @method init
    @within Shake
    @param CameraController table -- For Camera Instance
]=]
function Shake:init(CameraController)
    RunService:BindToRenderStep("ShakeEffect", Enum.RenderPriority.Camera.Value + 1, function()

    end)
end

return Shake
