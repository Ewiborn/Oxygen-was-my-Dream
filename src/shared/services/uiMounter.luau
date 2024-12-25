local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local React = require(ReplicatedStorage.Packages.react)
local ReactRoblox = require(ReplicatedStorage.Packages["react-roblox"])

local uiMounter = {}

uiMounter._roots = {}

function _createRoot()
    local rootContainer = Instance.new("Folder",Players.LocalPlayer.PlayerGui)
    rootContainer.Name = "RootContainer"

    local root = ReactRoblox.createRoot(rootContainer)

    return root
end

function _wrapInScreenGUI(createInterface : () -> GuiBase2d, RootId : string?) : ScreenGui
    return React.createElement("ScreenGui",{
        Name = "Root"..RootId or "New_Root",
        ScreenInsets = Enum.ScreenInsets.None,
        ResetOnSpawn = false
    },{
        React.createElement(createInterface)
    })
end

function uiMounter:mount(createInterface : () -> GuiBase2d) : string
    local rootId = HttpService:GenerateGUID(false)
    local root = _createRoot()

    root:render(_wrapInScreenGUI(createInterface,rootId))

    self._roots[rootId] = root

end

return uiMounter