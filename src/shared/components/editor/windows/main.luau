local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Iris = require(ReplicatedStorage.Packages.iris)

local EditorBehaviour = require(script.Parent.Parent.editorData)
local settings = require(script.Parent.settings)

return function ()
    Iris.Window({" Main Window "})
        
        
        Iris.MenuBar() 
        do
            Iris.Menu({ "Tools" })
            do
                Iris.MenuItem({ "Move", Enum.KeyCode.Q, Enum.ModifierKey.Ctrl })
                Iris.MenuItem({ "Scale", Enum.KeyCode.S, Enum.ModifierKey.Ctrl })
                Iris.MenuItem({ "Rotate", Enum.KeyCode.R, Enum.ModifierKey.Ctrl })
            end
            Iris.End()
            Iris.Menu({ "Gizmo" })
            do
                Iris.MenuItem({ "Show Faces", Enum.KeyCode.U, Enum.ModifierKey.Ctrl })
                Iris.MenuItem({ "Show Anchored", Enum.KeyCode.I, Enum.ModifierKey.Ctrl })
                Iris.MenuItem({ "Show CanCollide", Enum.KeyCode.O, Enum.ModifierKey.Ctrl })
            end
            Iris.End()
        end
        Iris.End()

        Iris.Text("Active Folder: " .. "not created" or EditorBehaviour.__currentFolder.Name)
        if Iris.Button({"Create new Folder"}).clicked() then 
            EditorBehaviour.__currentFolder = Instance.new("Folder", workspace)
            EditorBehaviour.__currentFolder.Name = tostring(math.random(1, 1000))
        end

        if Iris.Button({"Load Selected Folder"}).clicked() then
            Iris.Text({"Currently unavalable"})
        end
        Iris.Separator()
        

        Iris.CollapsingHeader({ "Instances" })
             if Iris.Button({ "Create" }).clicked() then
                local Instance : Instance = Instance.new("Part", workspace)

                table.insert(EditorBehaviour.__instance, Instance) 
             end

             Iris.Table({ 3 })
             do
                Iris.NextRow()
                Iris.NextColumn()
                Iris.Text({ "Name" })
                Iris.NextColumn()
                Iris.Text({ "Position" })
                Iris.NextColumn()
                Iris.Text({ "Properties" })

                for _, instance : Instance in ipairs(EditorBehaviour.__instance) do
                    Iris.NextRow() Iris.NextColumn()
                    Iris.Text({instance.Name})
                    Iris.NextColumn()
                    Iris.Text({tostring((instance.Position))})
                    Iris.NextColumn()
                    if Iris.Button({ "Open" }).clicked() then
                        Iris:Connect(settings)
                    end
                end

             end
             Iris.End()

        Iris.End()
        Iris.CollapsingHeader({ "Lighting" })
            Iris.InputColor3({ "Ambient" })
            Iris.InputNum({ "Brightness" })
            Iris.InputColor3({ "ColorShift Bottom" })
            Iris.InputColor3({ "ColorShift Top" })
            Iris.InputNum({ "Environment Diffuse Scale" })
            Iris.InputNum({ "Environment Specular Scale" })
            Iris.InputColor3({ "Outdoor Ambient" })
            Iris.InputNum({ "Shadow Softness" })
            Iris.InputNum({ "Time of Day" })
        Iris.End()

    Iris.End()
end