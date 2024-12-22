local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.react)

local contextProvider = require(ReplicatedStorage.Shared.components.ui.contextProvider.contextProvider)

local Item = React.PureComponent:extend("Item")

function Item:render()
    return React.createElement(contextProvider.Consumer,nil,function(context:{})
        return React.createElement("TextButton",{
            Size = UDim2.fromScale(1,1),
            BorderSizePixel = 0,
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            Text = ""
        },{
           ListLayout = React.createElement("UIListLayout",{
                Padding = UDim.new(0,5)
           }),
           ImageContainer = React.createElement("Frame",{
                Size = UDim2.fromScale(1,.75),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
           },{
                Image = React.createElement("ImageLabel",{
                    Image = "rbxassetid://"..7845625278,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.fromScale(1,1),
                    Position = UDim2.fromScale(.5,.5),
                    AnchorPoint = Vector2.new(.5,.5),
                },{
                    AspectRatio = React.createElement("UIAspectRatioConstraint"),
                    Corner = React.createElement("UICorner",{
                        CornerRadius = UDim.new(0,8),
                    })
                })
           }),
           InfoContainer = React.createElement("Frame",{
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.fromScale(1,0)
           },{
                FlexItem = React.createElement("UIFlexItem",{
                    FlexMode = Enum.UIFlexMode.Fill
                }),
                ListLayout = React.createElement("UIListLayout",{
                    Padding = UDim.new(0,5),
                    HorizontalAlignment = Enum.HorizontalAlignment.Center
                }),
                ATitle = React.createElement("TextLabel",{
                    Size = UDim2.fromScale(1,.5),
                    BackgroundTransparency = 1,
                    Text = self.props.Title or "Title",
                    FontFace = context.Font,
                    TextColor3 = context.FontColor,
                    TextSize = 14,
                }),
                TimeStamp = React.createElement("TextLabel",{
                    Size = UDim2.fromScale(1,.5),
                    BackgroundTransparency = 1,
                    Text = string.format("Updated %s",self.props.Title or "yesterday"),
                    FontFace = context.Font,
                    TextColor3 = context.FontColor,
                    TextSize = 12
                })
           })
        })
    end)
end

return Item