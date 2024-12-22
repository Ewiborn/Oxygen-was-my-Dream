local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.react)

local Button = require(ReplicatedStorage.Shared.components.ui.button.selectorButton)
local Item = require(ReplicatedStorage.Shared.components.ui.itemSpawner.item)

local itemSpawner = React.Component:extend("itemSpawner")

function itemSpawner:createButtons()
    local resultTable = {
        ["ListLayout"] = React.createElement("UIListLayout",{
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            Padding = UDim.new(0,5)
        })
    }

    for i=1,5 do
        table.insert(resultTable,React.createElement(Button,{
            Size = UDim2.fromScale(0,1) + UDim2.fromOffset(55,0)
        }))
    end

    return resultTable
end

function itemSpawner:createDummyContent() -- TEMP CODE!!!
    local resultTable = {
        React.createElement("UIGridLayout",{
            CellPadding = UDim2.fromOffset(5,5),
            CellSize = UDim2.fromOffset(134,160)
        })
    }

    for i=1,math.random(10,50) do
        table.insert(resultTable,React.createElement(Item))
    end

    return resultTable
end

function itemSpawner:render()
    return React.createElement("Frame",{
        Position = UDim2.fromScale(.5,.5),
        AnchorPoint = Vector2.new(.5,.5),
        Size = UDim2.fromScale(.75,.75),
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromHex("#0d0d0d")
    },{
        Corner = React.createElement("UICorner",{
            CornerRadius = UDim.new(0,7)
        }),
        Padding = React.createElement("UIPadding",{
            PaddingLeft = UDim.new(0,48),
            PaddingRight = UDim.new(0,48),
            PaddingTop = UDim.new(0,20),
            PaddingBottom = UDim.new(0,20)
        }),

        MainContent = React.createElement("Frame",{
            Size = UDim2.fromScale(.6,1),
            Position = UDim2.fromScale(0,.5),
            AnchorPoint = Vector2.new(0,.5),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
        },{
            ListLayout = React.createElement("UIListLayout",{
                Padding = UDim.new(0,5),
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }),
            ButtonsContainer = React.createElement("Frame",{
                Size = UDim2.fromScale(1,0) + UDim2.fromOffset(0,28),
                Position = UDim2.new(.5,0),
                AnchorPoint = Vector2.new(.5,0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
            },self:createButtons()),
            ItemsList = React.createElement("Frame",{
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.fromScale(1,0),
            },{
                FlexItem = React.createElement("UIFlexItem",{
                    FlexMode = Enum.UIFlexMode.Fill
                }),
                Scroll = React.createElement("ScrollingFrame",{
                    Size = UDim2.fromScale(1,1),
                    BackgroundTransparency = 1,
                    AutomaticCanvasSize = Enum.AutomaticSize.Y,
                    BorderSizePixel = 0,
                    ClipsDescendants = true
                },self:createDummyContent())
            })
        })
    })
end

return itemSpawner