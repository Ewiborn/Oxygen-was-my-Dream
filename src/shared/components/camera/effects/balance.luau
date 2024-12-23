local RunService = game:GetService("RunService")

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

local Balance: Effect = {
    name = "Balance",
    Attributes = {
        MaxSwayAngle = 10,
        SwaySpeed = 2,
        BalanceAmplitude = 5,
        BalanceSpeed = 2,
        Intensity = 0,
    },
    init = function(self, Parameters)
        RunService:BindToRenderStep("BalanceEffect", Enum.RenderPriority.Camera.Value + 1, function()
            local A = self.Attributes
            local B = math.sin(tick() * A.BalanceSpeed) * math.rad(A.BalanceAmplitude * A.Intensity)
            local SwayX = math.sin(tick() * A.SwaySpeed) * A.MaxSwayAngle * A.Intensity
            local SwayY = math.cos(tick() * A.SwaySpeed) * A.MaxSwayAngle * A.Intensity
            Parameters.CameraController.camera.CFrame = Parameters.CameraController.camera.CFrame:Lerp(
                Parameters.CameraController.camera.CFrame * CFrame.Angles(math.rad(SwayX), math.rad(SwayY), B),
                0.1
            )
        end)
    end,
}

return {
    Balance
}
