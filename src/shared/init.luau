local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- TEMP CODE

local uiMounter = require(ReplicatedStorage.Shared.services.uiMounter)

return function ()
   uiMounter:mount(require(ReplicatedStorage.Shared.components.ui.screens.itemSpawner))
end