local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--[[
/
*
*   Movement Controller
*   Added Component System with Attributes support
*
/
]]

--[=[
	@class MovementController
    

	Contains API to control movement behaviour
]=]

local MovementController = {}

MovementController.Player = Players.LocalPlayer
MovementController.Character = Players.LocalPlayer.Character or nil

MovementController.CameraController = require(ReplicatedStorage.Shared.components.camera.cameraController)
MovementController.Controls = require(script.Parent.classes.controls).new()

MovementController.Rays = { HeadForward = nil, TorsoForward = nil, TorsoDown = nil }
MovementController.RayLenght = 15 -- lenght in studs.

MovementController.Components = {}


MovementController.__characterRaycastParametrs = {}

--[=[
    @prop Player Player
    @tag Player

    @within MovementController
]=]

--[=[
    @prop Character Model
    @tag Player

    @within MovementController
]=]

--[=[
    @prop Rays array
    @tag Arrays
    @tag Raycast

    @within MovementController
    A table containing the following fields:
    - TorsoFoward: RaycastResult 
    - HeadForward: RaycastResult 
    - TorsoDown: RaycastResult 
]=]

--[=[
    @prop RayLenght number
    @tag Raycast

    @within MovementController
]=]

type Rays = {
    HeadForward : RaycastResult,
    TorsoForward : RaycastResult,
    TorsoDown : RaycastResult
}

export type Component = {
    Attributes : { any }?,
    init : ( MovementController ) -> (),
}

export type MovementController = {
    Player : Player,
    Character : Model,
    Controls : { Enum.KeyCode },
    Rays : Rays,
    RayLenght : number,
    Components : { Component }
}


--[=[
Initializes all childrens
@tag Setup
@unreleased
]=]
function MovementController:init()
    self.Character = self.Player.Character or self.Player.CharacterAdded:Wait()

    self.__characterRaycastParametrs = RaycastParams.new()
    self.__characterRaycastParametrs.FilterType = Enum.RaycastFilterType.Exclude
    self.__characterRaycastParametrs.FilterDescendantsInstances = { self.Character }

    local success : boolean, response : string = pcall(function()

        --[[
        /// Init Global Components
        ]]

        self.CameraController:init() -- TODO: Setup this from shared 

        for _, component : ModuleScript in script.Parent.obstacles:GetChildren() do
            table.insert(self.Components, component)
        end

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

--[=[
Sets attributes for a specified component. Accepts either a key-value pair or a table of key-value pairs.
@tag Attribute
@since 0.03b

@param Name string -- The name of the effect to modify.
@param keyOrTable string|table -- The attribute key or a table of key-value pairs.
@param value any -- The value to set for the specified key (ignored if keyOrTable is a table).
]=]
function MovementController:setAttribute(Name, keyOrTable, value)
    local success : boolean, response : string = pcall(function()
        local component = self.Components[Name]

        if typeof(keyOrTable) == "string" then
            component.Attributes[keyOrTable] = value
        elseif typeof(keyOrTable) == "table" then
            for key, val in pairs(keyOrTable) do
                component.Attributes[key] = val
            end
        end

    end)

    if not success then warn(string.format("[%s] %s", "Movement", response)) return end
end

--[=[
Retrieves the value of a specified attribute for a given effect. If no key is provided, returns all attributes.
@tag Attribute

@param Name string -- The name of the effect to query.
@param key string? key -- The specific attribute key to retrieve (optional).
@return any -- The value of the specified attribute, or a table of all attributes if no key is provided.
]=]
function MovementController:getAttribute(Name : string, key : string?)
    local component = self.Components[Name]

    if not component then
        return nil
    end

    if key then
        return component.Attributes[key]
    end

    return component.Attributes
end

--[=[
Sets component attribute given value 
@tag Instance
@tag Component
@since 0.03b
]=]
function MovementController:getComponent(Name : string)
    return self.Components[Name]
end


return MovementController