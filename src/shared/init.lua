local ReplicatedStorage = game:GetService("ReplicatedStorage")

local uiMounter = require(ReplicatedStorage.Shared.services.uiMounter)

return function ()
   require(script.components.camera.cameraController):init()
   require(script.components.movement.movementController):init()

   --uiMounter:mount(require(ReplicatedStorage.Shared.components.ui.screens.itemSpawner))
end