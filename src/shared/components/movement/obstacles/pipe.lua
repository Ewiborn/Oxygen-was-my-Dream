local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local VectorUtils = require(ReplicatedStorage.Shared.utils.vector)

local Pipe = {}
Pipe.Attributes = {
    Size = Vector3.new(10, 0, 10)
}

--[[
/
*
*   Pipe Abbility
*
/
]]

--[=[
	@class Pipe

	Pipe Movement System
]=]


<<<<<<< HEAD
function Pipe:init(MovementController)
=======
	@method init
	@within Pipe
]=]
function Pipe:init(MovementController : {MovementController: {}})
>>>>>>> f3532c9ef4407e872ac935dc6e6ee55946b0c20e
    --[[
    /
    *
    *  Pipe Cycle
    *
    /
    ]]
    RunService.RenderStepped:Connect(function(deltaTime)
        
        if not MovementController.Rays.TorsoDown then return end
        if not MovementController.Rays.TorsoDown.Instance or not VectorUtils:CompareVector3XY(self.Attributes.Size, MovementController.Rays.TorsoDown.Instance.Size) then return end
        

        --MovementController.CameraController:setAttribute("Balance", "Intensity", 4)

    end)
end

return Pipe