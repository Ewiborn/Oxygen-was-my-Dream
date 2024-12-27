local Table = {}

--[=[
	@class Table

	Table Utilities
]=]

-- TODO: Write moonware docs

function Table:GetNearestValue(Table : {}, Number : string)
    table.sort(Table, function(Left, Right) return math.abs(Number - Left) < math.abs(Number - Right) end)
	return Table[1]
end

return Table