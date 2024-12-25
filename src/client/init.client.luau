local ReplicatedStorage = game:GetService("ReplicatedStorage")

repeat
    task.wait()    
until workspace.CurrentCamera.ViewportSize.X > 0

require(ReplicatedStorage.Shared)()