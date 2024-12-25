local Vector = {}

--[=[
	@class Vector

	Contains API to control camera effects
]=]


--[=[
	This is a very fancy function that adds a couple numbers.

	@method CompareVector3
	@within Vector
]=]
function Vector:CompareVector3(A : Vector3, B : Vector3)
    return B.X > A.X and B.Y > A.Y and B.Z > A.Z
end


--[=[
	This is a very fancy function that adds a couple numbers.

	@method CompareVector3XY
	@within Vector
]=]
function Vector:CompareVector3XY(A : Vector3, B : Vector3)
    return B.X > A.X and B.Z > A.Z
end


--[=[
	This is a very fancy function that adds a couple numbers.

	@method CompareVector2
	@within vector
]=]
function Vector:CompareVector2(A : Vector2, B : Vector2)
    return B.X > A.X and B.Y > A.Y
end

return Vector