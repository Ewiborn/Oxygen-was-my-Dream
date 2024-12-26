local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Vaulting = {}
Vaulting.Attributes = {
    OffsetY = 6,
    OffsetX = 1.5,
    ClimbSpeed = 1,
    GrabLerpSpeed = 10, -- the hiegher - the slower

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

function calcGrabPos(hitPos:Vector3,RightVector:Vector3,normalVector:Vector3) : CFrame
    return CFrame.fromMatrix(hitPos,RightVector,normalVector,RightVector:Cross(normalVector))
end

function Vaulting:onJump(MovementController)
    if not self.active then return end

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

    local Offset : Vector3 = (MovementController.Rays.TorsoForward.Position - VaultPart.Position).Unit
    Offset = Offset * (Vector3.new(1,1,1) - (Side:Abs()+Vector3.new(0,1,0)))

    local PartPosition = calcGrabPos(MovementController.Rays.TorsoForward.Position,VaultPart.CFrame.RightVector,Side) 
    PartPosition = Vector3.new(PartPosition.X,VaultPart.Position.Y + (VaultPart.Size*VaultPart.CFrame.UpVector).Magnitude/2 - Vaulting.Attributes.OffsetY/2,PartPosition.Z) :: Vector3

    MovementController.Character.PrimaryPart.Anchored = true
    
    local animSpeed : number = Vaulting.Attributes.GrabLerpSpeed

    for i = 1,animSpeed do
        MovementController.Character:PivotTo(MovementController.Character.PrimaryPart.CFrame:Lerp(CFrame.lookAlong(PartPosition + Side * Vaulting.Attributes.OffsetX,-Side),1/animSpeed*i))
        task.wait()
    end

    if VaultPart.Anchored == false then
        local lastPos : Vector3 = Vector3.zero
        self.grabBinding = RunService.Heartbeat:Connect(function()
            local TorsoRay : RaycastResult = MovementController.Rays.TorsoForward

            if not VaultPart then self:onJump(MovementController) return end
            if not TorsoRay then self:onJump(MovementController) return end
            if TorsoRay.Distance > 2 then self:onJump(MovementController) return end
            if lastPos == TorsoRay.Position then return end

            Side = TorsoRay.Normal :: Vector3

            local PartPosition = calcGrabPos(TorsoRay.Position,VaultPart.CFrame.RightVector,Side) 
            PartPosition = Vector3.new(PartPosition.X,VaultPart.Position.Y + (VaultPart.Size*VaultPart.CFrame.UpVector).Magnitude/2 - Vaulting.Attributes.OffsetY/2,PartPosition.Z) :: Vector3

            MovementController.Character:PivotTo(MovementController.Character.PrimaryPart.CFrame:Lerp(CFrame.lookAlong(PartPosition + Side * Vaulting.Attributes.OffsetX,-Side),.5))

            lastPos = TorsoRay.Position
        end)
    end

    self.UISConnection = UserInputService.JumpRequest:Connect(function()
        self:onJump(MovementController)
    end)
end

function Vaulting:checkUpCollision(MovementController : {})
    local TorsoRay = MovementController.Rays.TorsoForward

    local CheckPosition = TorsoRay.Position - Vector3.new(0,TorsoRay.Position.Y - TorsoRay.Instance.Position.Y,0) + Vector3.new(0,TorsoRay.Instance.Size.Y/2+1.5,0)
    local PartsList = workspace:GetPartBoundsInBox(CFrame.new(CheckPosition),Vector3.new(.5,.5,.5))

    if #PartsList == 0 then return false end
    return true
end

function Vaulting:init(MovementController : {MovementController: {}})
    --[[
    /
    *
    *  Vault Cycle
    *
    / 
    ]]

    self.runServiceBinding = RunService.PreRender:Connect(function()
        local TorsoRay = MovementController.Rays.TorsoForward

        if not TorsoRay then return end
		if not TorsoRay["Instance"] then return end
        if TorsoRay.Distance > 2 then return end    

        if MovementController.Rays.HeadUp  then
            if MovementController.Rays.HeadUp.Distance < 2 then self:onJump(MovementController) return end
         end

         if self:checkUpCollision(MovementController) then return end

        if TorsoRay.Instance.Parent:FindFirstChildWhichIsA("Humanoid") or TorsoRay.Instance.Parent.Parent:FindFirstChildWhichIsA("Humanoid") then return end

        local UpVector = TorsoRay.Instance.CFrame.RightVector:Cross(TorsoRay.Instance.CFrame.LookVector)
        local PartSize = math.abs((TorsoRay.Instance.Size * UpVector).Magnitude)

        if TorsoRay.Position.Y  < PartSize/2 - Vaulting.Attributes.OffsetY + TorsoRay.Instance.Position.Y then return end

        self:vault(MovementController,TorsoRay.Normal)
	end)
end

return Vaulting