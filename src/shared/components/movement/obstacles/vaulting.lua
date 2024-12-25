local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Vaulting = {}
Vaulting.Attributes = {
    OffsetY = 6,
    OffsetX = 1.5,
    ClimbSpeed = 1
}

--[[
/
*
*   Vaulting Abbility
*
/
]]

--[=[
	@class Vaulting

	Contains API to control camera effects
]=]

--[=[
	This is a very fancy function that adds a couple numbers.

	@method init
	@within Vaulting
]=]

function calcGrabPos(hitPos:Vector3,RightVector:Vector3,normalVector:Vector3):CFrame
    return CFrame.fromMatrix(hitPos,RightVector,normalVector,RightVector:Cross(normalVector))
end

function Vaulting:onJump(MovementController)
    if self.UISConnection then self.UISConnection:Disconnect() end

    self.cooldown = true
    if self.grabBinding then self.grabBinding:Disconnect() end
    MovementController.Character.PrimaryPart.Anchored = false
    MovementController.Character.PrimaryPart:ApplyImpulse(Vector3.new(0,500,0))
    self.active = false

    task.wait(.5)

    self.cooldown = false

end

function Vaulting:vault(MovementController : {MovementController : {}},Side:Vector3)
    if self.active or self.cooldown then return end

    self.active = true
    local VaultPart = MovementController.Rays.TorsoForward.Instance :: Part

    local Offset = (MovementController.Rays.TorsoForward.Position - VaultPart.Position).Unit
    Offset = Offset * (Vector3.new(1,1,1) - (Side:Abs()+Vector3.new(0,1,0)))
    Offset = Offset

    local PartPosition = calcGrabPos(MovementController.Rays.TorsoForward.Position,VaultPart.CFrame.RightVector,Side) 
    PartPosition = Vector3.new(PartPosition.X,VaultPart.Position.Y + (VaultPart.Size*VaultPart.CFrame.UpVector).Magnitude/2 - Vaulting.Attributes.OffsetY/2,PartPosition.Z)

    MovementController.Character.PrimaryPart.Anchored = true
    MovementController.Character:PivotTo(CFrame.lookAlong(PartPosition + Side * Vaulting.Attributes.OffsetX,-Side))

    if VaultPart.Anchored == false then
        local lastPos = Vector3.zero
        self.grabBinding = RunService.Heartbeat:Connect(function()
            if not VaultPart then self:onJump(MovementController) return end
            if not MovementController.Rays.TorsoForward then self:onJump(MovementController) return end
            if MovementController.Rays.TorsoForward.Distance > 2 then self:onJump(MovementController) return end
            if lastPos == MovementController.Rays.TorsoForward.Position then return end

            Side = MovementController.Rays.TorsoForward.Normal

            local PartPosition = calcGrabPos(MovementController.Rays.TorsoForward.Position,VaultPart.CFrame.RightVector,Side) 
            PartPosition = Vector3.new(PartPosition.X,VaultPart.Position.Y + (VaultPart.Size*VaultPart.CFrame.UpVector).Magnitude/2 - Vaulting.Attributes.OffsetY/2,PartPosition.Z)
            MovementController.Character:PivotTo(CFrame.lookAlong(PartPosition + Side * Vaulting.Attributes.OffsetX,-Side))

            lastPos = MovementController.Rays.TorsoForward.Position
        end)
    end

    self.UISConnection = UserInputService.JumpRequest:Connect(function()
        self:onJump(MovementController)
    end)
end

function Vaulting:init(MovementController : {MovementController: {}})
    --[[
    /
    *
    *  Vault Cycle
    *
    / 
    ]]

    self.runServiceBinding = RunService.PreRender:Connect(function(deltaTimeRender)
        if not MovementController.Rays.TorsoForward then return end
		if not MovementController.Rays.TorsoForward["Instance"] then return end
        if MovementController.Rays.TorsoForward.Distance > 2 then return end    

        if MovementController.Rays.TorsoForward.Position.Y < MovementController.Rays.TorsoForward.Instance.Size.Y - Vaulting.Attributes.OffsetY then print("not enough height") return end

        self:vault(MovementController,MovementController.Rays.TorsoForward.Normal)
	end)
end

return Vaulting