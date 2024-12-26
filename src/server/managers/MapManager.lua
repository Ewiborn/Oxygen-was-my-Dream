local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.Shared.utils.signalLib)


local MapManager = {
    level = nil,
    sub = ReplicatedStorage.Assets.map,
    __signals = nil,
    __settings = nil,
    OnInstanceType = Signal.new(),
    OnLoadCall = Signal.new(),
    OnUnloadCall = Signal.new()
}

type LoadParameters = {
    InstanceFind : any,
}


function MapManager:load(Parameters : LoadParameters)
    if self.level then self:unload() end self.OnLoadCall:Fire()

    local success : boolean, message : string = pcall(function()
    
        if typeof(Parameters.InstanceFind) == "string" and self.sub then self.level = self.sub[Parameters.InstanceFind] end 
        if typeof(Parameters.InstanceFind) == "Instance" and self.sub then self.level = Parameters.InstanceFind end 

        self.OnInstanceType:Fire(self.level)

        self.__settings = require(self.level.settings) or { Name = "???", Description = "????? ?? ?????" }
        self.__signals = require(self.level.signals) or nil

    end)

    if not success then return false, message end
end

function MapManager:call(name : string)
    if not self.__signals then return false, "signal module is not asginned" end

    local success : string, message : string = pcall(function()
        if not self.__signals[name] then return false, string.format("Signal '%s' not found", name) end

        self.__signals[name](self)
    end)

    if not success then return false, message end
end

function MapManager:unload()
    self.OnUnloadCall:Fire()
end


return MapManager