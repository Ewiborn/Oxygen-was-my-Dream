local RunService = game:GetService("RunService")

--[=[
    @class Balance

    Contains API to control camera effects
]=]
local Balance = {}

-- Documenting the Attributes property
--[=[
    @prop Attributes table
    @within Balance
    A table containing the following fields:
    - MaxSwayAngle: number -- Maximum sway angle.
    - SwaySpeed: number -- Speed of the sway.
    - BalanceAmplitude: number -- Amplitude of the balance effect.
    - BalanceSpeed: number -- Speed of the balance effect.
    - Intensity: number -- Intensity of the effect.
]=]
Balance.Attributes = {
    MaxSwayAngle = 10,
    SwaySpeed = 2,
    BalanceAmplitude = 5,
    BalanceSpeed = 2,
    Intensity = 0.1,
}

--[=[
    Initializes the Balance effect by binding it to the render step.

    @method init
    @within Balance
    @param CameraController table -- For Camera Instance
]=]
function Balance:init(CameraController)
    RunService:BindToRenderStep("BalanceEffect", Enum.RenderPriority.Camera.Value + 1, function()
        local A = Balance.Attributes
        local B = math.sin(tick() * A.BalanceSpeed) * math.rad(A.BalanceAmplitude * A.Intensity)
        local SwayX = math.sin(tick() * A.SwaySpeed) * A.MaxSwayAngle * A.Intensity
        local SwayY = math.cos(tick() * A.SwaySpeed) * A.MaxSwayAngle * A.Intensity
        CameraController.camera.CFrame = CameraController.camera.CFrame:Lerp(
            CameraController.camera.CFrame * CFrame.Angles(math.rad(SwayX), math.rad(SwayY), B),
            0.1
        )
    end)
end

return Balance
