local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

--[[
/
*
*   Movement Controller
*
/
]]

local MovementController = {}

MovementController.Player = Players.LocalPlayer
MovementController.Character = nil

MovementController.Rays = { HeadForward = nil, TorsoForward = nil, }
MovementController.RayLenght = 15 -- lenght in studs.


MovementController.__characterRaycastParametrs = {}


function MovementController:init()
    self.Character = self.Player.Character or self.Player.CharacterAdded:Wait()

    self.__characterRaycastParametrs = RaycastParams.new()
    self.__characterRaycastParametrs.FilterType = Enum.RaycastFilterType.Exclude
    self.__characterRaycastParametrs.FilterDescendantsInstances = { self.Character }

    local success : boolean, response : string = pcall(function()
        require(script.Parent.obstacles.vaulting):init(self)
    end)

    RunService:BindToRenderStep("Raycasts", Enum.RenderPriority.Character.Value + 1, function()

        --[[
        /// Head Forward Raycast
        ]]

        self.Rays.HeadForward = workspace:Raycast(
            self.Character.Head, 
            self.Character.Head.CFrame.LookVector * self.RayLenght,
            self.__characterRaycastParametrs
        )

        --[[
        /// Torso Forward Raycast
        ]]

        self.Rays.TorsoForward = workspace:Raycast(
            self.Character.Torso, 
            self.Character.Torso.CFrame.LookVector * self.RayLenght,
            self.__characterRaycastParametrs
        )

    
    end)

    if not success then warn(string.format("[%s] %s", "Movement", response)) return else print(string.format("[%s] %s", "Movement", "Succesfully inited components")) end
end

return MovementController