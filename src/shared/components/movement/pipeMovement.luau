local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local PipeMovement = {}
PipeMovement.Properties = {
    MaxSwayAngle = 10,
    SwaySpeed = 2,
    BalanceAmplitude = 5,
    MaxBalanceAmplitude = 45,
    BalanceSpeed = 2,
    TimeToMaxIntensity = 5,
    Direction = Vector3.new(0, -5, 0),
    CameraOffset = Vector3.new(0, 0, -5)
}

function PipeMovement:init()
    local Player = Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    local Camera = Workspace.CurrentCamera

    local TimeElapsed = 0
    local Intensity = 0
    local SwayAngleX = 0
    local SwayAngleY = 0
    local MouseDelta = Vector2.new(0, 0)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            MouseDelta = input.Delta
        end
    end)

    RunService:BindToRenderStep("PipeBehaviour", Enum.RenderPriority.Camera.Value + 1, function(deltaTime)
        local RaycastParams = RaycastParams.new()
        RaycastParams.FilterDescendantsInstances = { Character }
        RaycastParams.FilterType = Enum.RaycastFilterType.Exclude

        local RaycastResult = Workspace:Raycast(
            HumanoidRootPart.Position,
            self.Properties.Direction,
            RaycastParams
        )

        local BalanceAngle = 0
        if RaycastResult and RaycastResult.Instance and RaycastResult.Instance.Size and RaycastResult.Instance.Size.Z < 10 then
            TimeElapsed += deltaTime
            Intensity = math.min(TimeElapsed / self.Properties.TimeToMaxIntensity, 1)

            BalanceAngle = math.sin(TimeElapsed * self.Properties.BalanceSpeed) 
                * math.rad(self.Properties.BalanceAmplitude 
                + (self.Properties.MaxBalanceAmplitude - self.Properties.BalanceAmplitude) * Intensity)

        end

        local TargetSwayX = math.clamp(-MouseDelta.Y / 50, -self.Properties.MaxSwayAngle, self.Properties.MaxSwayAngle)
        local TargetSwayY = math.clamp(MouseDelta.X / 50, -self.Properties.MaxSwayAngle, self.Properties.MaxSwayAngle)

        SwayAngleX = SwayAngleX + (TargetSwayX - SwayAngleX) * self.Properties.SwaySpeed * deltaTime
        SwayAngleY = SwayAngleY + (TargetSwayY - SwayAngleY) * self.Properties.SwaySpeed * deltaTime

        local TargetCFrame = Camera.CFrame
            * CFrame.Angles(math.rad(SwayAngleX), math.rad(SwayAngleY), BalanceAngle)
            * CFrame.new(self.Properties.CameraOffset) 

        Camera.CFrame = Camera.CFrame:Lerp(TargetCFrame, 0.1)
    end)
end

return PipeMovement
