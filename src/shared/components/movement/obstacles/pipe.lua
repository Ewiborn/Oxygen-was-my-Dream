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


function Pipe:init(MovementController)
    --[[
    /
    *
    *  Pipe Cycle
    *
    /
    ]]
    RunService.RenderStepped:Connect(function(deltaTime)
        
    end)
end

return Pipe