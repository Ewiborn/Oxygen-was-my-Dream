local Vector = {}

--[=[
	@class Vector

	Vector Utilities
]=]


--[=[
Returns boolean, if (A) vector is bigger than (B) vector
@tag Vector3

@param B vector3
@param A vector3
@return boolean 
]=]
function Vector:CompareVector3(A : Vector3, B : Vector3)
    return B.X > A.X and B.Y > A.Y and B.Z > A.Z
end


--[=[
Returns boolean, if (A) vector is bigger than (B) vector
@tag Vector3

@param B vector3
@param A vector3
@return boolean 
]=]
function Vector:CompareVector3XY(A : Vector3, B : Vector3)
    return B.X > A.X and B.Z > A.Z
end


--[=[
Returns boolean, if (A) vector is bigger than (B) vector
@tag Vector2

@param B vector2
@param A vector2
@return boolean 
]=]
function Vector:CompareVector2(A : Vector2, B : Vector2)
    return B.X > A.X and B.Y > A.Y
end

return Vector