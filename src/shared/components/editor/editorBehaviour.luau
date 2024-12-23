local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Iris = require(ReplicatedStorage.Packages.iris).Init()

local MainWindow = require(script.Parent.windows.main)

local EditorBehaviour = {}

function EditorBehaviour:init()
    Iris:Connect(MainWindow)
end

return EditorBehaviour