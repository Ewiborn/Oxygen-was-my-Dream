local ReplicatedStorage = game:GetService("ReplicatedStorage")

return function ()
   require(script.components.camera.cameraController):init()
   require(script.components.movement.movementController):init()
end