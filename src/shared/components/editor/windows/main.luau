local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Iris = require(ReplicatedStorage.Packages.iris)

local EditorBehaviour = require(script.Parent.Parent.editorData)
local settings = require(script.Parent.settings)

local function ShowMenuBar()
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
        Iris.Menu({ "Windows" })
        do
            if Iris.MenuItem({ "Properties", Enum.KeyCode.P, Enum.ModifierKey.Ctrl }).clicked() then Iris:Connect(settings) end
            if Iris.MenuItem({ "Explorer", Enum.KeyCode.E, Enum.ModifierKey.Ctrl }).clicked() then Iris:Connect(settings) end
            if Iris.MenuItem({ "Debug", Enum.KeyCode.G, Enum.ModifierKey.Ctrl }).clicked() then Iris:Connect(settings) end
        end
        Iris.End()
    end
    Iris.End()
end

local function ShowFolderCategory()
    Iris.Text("Active Folder: " .. "not created" or EditorBehaviour.__currentFolder.Name)

    if Iris.Button({"Create new Folder"}).clicked() then 
        EditorBehaviour.__currentFolder = Instance.new("Folder", workspace)
        EditorBehaviour.__currentFolder.Name = tostring(math.random(1, 1000))
    end

    if Iris.Button({"Load Selected Folder"}).clicked() then
        Iris.Text({"Currently unavalable"})
    end

end

local function ShowInstanceCategory()

    Iris.CollapsingHeader({ "Instances" })
             if Iris.Button({ "Create" }).clicked() then
                local Instance : Instance = Instance.new("Part", workspace)
                table.insert(EditorBehaviour.__instance, Instance) 
             end

             Iris.Table({ 2 })
             do

                Iris.NextRow()
                Iris.NextColumn()
                Iris.Text({ "Name" })
                Iris.NextColumn()
                Iris.Text({ "Properties" })

                for _, instance : Instance in ipairs(EditorBehaviour.__instance) do
                    Iris.NextRow() Iris.NextColumn()
                    Iris.Text({instance.Name})
                    Iris.NextColumn()
                    if Iris.Button({ "Open" }).clicked() then
                        Iris:Connect(settings)
                    end
                end

             end
             Iris.End()
     Iris.End()

end

local function ShowMapData()
    Iris.CollapsingHeader({ "Map Data" })
    Iris.Text({ "Current Map: %s" })

    Iris.Button({ " Requst " })
    Iris.Button({ " Remove "})
    Iris.Separator()

    Iris.Table({ 3 })
    do

       Iris.NextRow()
       Iris.NextColumn()
       Iris.Text({ "Callback Name" })
       Iris.NextColumn()
       Iris.Text({ "State" })
    end
    Iris.End()
Iris.End()
end

local function ShowManagers()
    Iris.CollapsingHeader({ "Managers" })
        Iris.TextColored({ "not done, yet :x", Color3.fromRGB(100, 255, 255)})
    Iris.End()
end

return function ()
    Iris.Window({" Main Window "})

        ShowMenuBar()
        ShowFolderCategory()

        Iris.Text({ "" })
        Iris.Separator()
        
        ShowInstanceCategory()

        Iris.Text({ "" })
        Iris.Separator()

        ShowManagers()

        Iris.Text({ "" })
        Iris.Separator()

        ShowMapData()

        Iris.CollapsingHeader({ "Upload" })
            Iris.Button({ " Send Changes To Server " })
            Iris.Separator()

            Iris.SliderNum({ "Upload Rate" })
            Iris.Checkbox(({ "Auto Upload" }))

            Iris.Tree({ "Collaborators "})
            
                Iris.Text({"Players"})
                Iris.Table({ 2 })
                do
                    Iris.NextRow()
                    Iris.NextColumn()
                    Iris.Text({ "User" })

                    Iris.NextColumn()
                    Iris.Text({ "" })

                    for _, player : Player in ipairs(Players:GetPlayers()) do
                        Iris.NextRow() Iris.NextColumn()
                        Iris.Text({player.Name})
                        Iris.NextColumn()
                        if Iris.Button({ "Add" }).clicked() then
                            print("idk")
                        end
                    end
                end
                Iris.End()

                Iris.Text({"Collaborators"})
                Iris.Table({ 2 })
                do
                    Iris.NextRow()
                    Iris.NextColumn()
                    Iris.Text({ "Player" })
                    Iris.NextColumn()
                    Iris.Text({ "Permission" })
                end

            Iris.End()

            Iris.Separator()
            Iris.TextColored({" Upload Status: not done, yet", Color3.fromRGB(253, 202, 126)})
        Iris.End()
        
    Iris.End()
end