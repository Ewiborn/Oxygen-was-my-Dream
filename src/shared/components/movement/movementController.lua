local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--[[
/
*
*   Movement Controller
*
/
]]

--[=[
	@class MovementController

	Contains API to control camera effects
]=]

local MovementController = {}

MovementController.Player = Players.LocalPlayer
MovementController.Character = Players.LocalPlayer.Character or nil

MovementController.CameraController = require(ReplicatedStorage.Shared.components.camera.cameraController)
MovementController.Controls = require(script.Parent.classes.controls).new()

MovementController.Rays = { HeadForward = nil, TorsoForward = nil, TorsoDown = nil }
MovementController.RayLenght = 15 -- lenght in studs.


MovementController.__characterRaycastParametrs = {}


--[=[
	This is a very fancy function that adds a couple numbers.

	@method init
	@within MovementController
]=]
function MovementController:init()
    self.Character = self.Player.Character or self.Player.CharacterAdded:Wait()

    self.__characterRaycastParametrs = RaycastParams.new()
    self.__characterRaycastParametrs.FilterType = Enum.RaycastFilterType.Exclude
    self.__characterRaycastParametrs.FilterDescendantsInstances = { self.Character }

    local success : boolean, response : string = pcall(function()

        --[[
        /// Init Components
        ]]

        self.CameraController:init()

        --[[
        /// Init Abbilities
        ]]
        -- require(script.Parent.obstacles.vaulting):init(self)
        require(script.Parent.obstacles.pipe):init(self)
        -- require(script.Parent.obstacles.wallRun):init(self)
    end)

    RunService:BindToRenderStep("Raycasts", Enum.RenderPriority.Character.Value + 1, function()

        --[[
        /// Head Forward Raycast
        ]]

        self.Rays.HeadForward = workspace:Raycast(
            self.Character.Head.Position, 
            self.Character.Head.CFrame.LookVector * self.RayLenght,
            self.__characterRaycastParametrs
        )

        --[[
        /// Torso Forward Raycast
        ]]

        self.Rays.TorsoForward = workspace:Raycast(
            self.Character.Torso.Position, 
            self.Character.Torso.CFrame.LookVector * self.RayLenght,
            self.__characterRaycastParametrs
        )

        --[[
        /// Torso Down Raycast
        ]]
        
        self.Rays.TorsoDown = workspace:Raycast(
            self.Character.Torso.Position, 
            Vector3.new(0, -1, 0) * self.RayLenght,
            self.__characterRaycastParametrs
        )

    
    end)

    if not success then warn(string.format("[%s] %s", "Movement", response)) return else print(string.format("[%s] %s", "Movement", "Succesfully inited components")) end
end

return MovementController