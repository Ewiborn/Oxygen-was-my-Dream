local Sound = {}
Sound.__index = Sound

type Attributes = {

}

export type Properties = {
    Name : string,
    Attributes : Attributes?
}

export type Sound = {
    Name : string,
    Attributes : Attributes?
}

function Sound.new(Properties : Properties): Sound
    local self = setmetatable({
        Name = "???" or Properties.Name,
        Attributes = {}
    }, Sound)
end

return Sound