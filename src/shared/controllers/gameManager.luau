--[[ 
  ---- //// GameManager (not wrapper)
]]

local GameManager = {}
GameManager.systems = { table }
GameManager.__inted = false

export type GameManager = {
    systems : {},
    __inted : boolean,
}

function GameManager:init()
    if self.__inted then return end

    local success : boolean, message : string = pcall(function()
        
        --[[
        /// E-C-S Initalization
        ]]

        self.systems.CameraController = require(script.Parent.cameraController):init()
        self.systems.MovementController = require(script.Parent.movementController):init()
    end)

    if not success then error(string.format("[%s] %s", "GameManager",  message))return success, message end

    print("Succesfully inited all global components")
end

return GameManager