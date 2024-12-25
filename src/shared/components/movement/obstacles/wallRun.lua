local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local VectorUtils = require(ReplicatedStorage.Shared.utils.vector)

local WallRun = {}

--[[
/
*
*   WallRun Abbility
*
/
]]

--[=[
	@class Wallrun

	Contains API to control camera effects
]=]

--[=[
	This is a very fancy function that adds a couple numbers.

	@method init
	@within Wallrun
]=]
function WallRun:init(MovementController : {MovementController: {}})
	
end

return WallRun