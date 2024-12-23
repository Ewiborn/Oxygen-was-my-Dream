local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Iris = require(ReplicatedStorage.Shared.Iris).Init()

local function Explorer()
    Iris.Window({"Explorer"})
       Iris.Tree({" Instances "})
          for index, instance in game.Workspace:GetDescendants() do
            Iris.Selectable({instance.Name, index}, {index = Iris.State(1)})
          end
       Iris.End()
    Iris.End()
end

Iris:Connect(Explorer)