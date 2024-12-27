local RunService = game:GetService("RunService")
local TableUtils = require(game.ReplicatedStorage.Shared.utils.table)

local FaillingBehaviour = {}
FaillingBehaviour.Attributes = {
    table = require(script.Parent.Parent.movementAnimations.fall)
}
FaillingBehaviour.Shared = {
    height = 0,
    distance = 0
}

--[[
/
*
*   Falling Behaviour
*   Plays animation when player fall from distance.
*
/
]]


function FaillingBehaviour:init(MovementController)

    MovementController.Character.Humanoid.StateChanged:Connect(function(old, new)

        --[[
          /// Get height and calculate falled distance
        ]]

        if new == Enum.HumanoidStateType.Freefall then 
            self.height = MovementController.Character.HumanoidRootPart.Position.y
        elseif old == Enum.HumanoidStateType.Freefall and new == Enum.HumanoidStateType.Landed then
             self.distance = self.height - MovementController.Character.HumanoidRootPart.Position.y
        end

        --[[
          /// Parsing fall distance, with given table 
        ]]

        local Animations : {} = TableUtils:GetNearestValue(self.Attributes.table.fall, self.Shared.height)
        local AnimationID : string = math.random(#Animations, 1) 
        
    end)

end

return FaillingBehaviour