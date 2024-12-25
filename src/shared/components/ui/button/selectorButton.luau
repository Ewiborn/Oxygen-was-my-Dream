local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.react)

local contextProvider = require(ReplicatedStorage.Shared.components.ui.contextProvider.contextProvider)

local booleanToNum = {
    [true] = 1,
    [false] = 0,
}

local selectorButton = React.Component:extend("selectorButton")

function selectorButton:init()
    self.state = {
        selected = false
    }

    self.animBinding,self.setAnim = React.createBinding(0)
end

function selectorButton:render() -- TODO: add animations and interaction events
    return React.createElement(contextProvider.Consumer,nil,function(context:{})
        return React.createElement("TextButton",{
            Text = self.props.Text or "Label",
            BackgroundTransparency = self.animBinding:map(function(value:number)
                return 1 - value
            end),
            BackgroundColor3 = context.SelectedColor,
            FontFace = Font.fromEnum(Enum.Font.GothamBold),
            TextColor3 = context.UnSelectedColor,
            TextSize = 14,
            BorderSizePixel = 0,
            Size = self.props.Size,
            AutomaticSize = Enum.AutomaticSize.X,
            AutoButtonColor = false
        },{
            Corner = React.createElement("UICorner",{
                CornerRadius = UDim.new(0,7),
            }),
            Stroke = React.createElement("UIStroke",{
                Thickness = 1,
                Color = context.UnSelectedColor,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            }),
            Padding = React.createElement("UIPadding",{
                PaddingRight = UDim.new(0,5),
                PaddingLeft = UDim.new(0,5),
            })
        })
    end)
end

return selectorButton