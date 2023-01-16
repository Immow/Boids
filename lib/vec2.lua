local Vec2 = {}
local Vec2_meta = {}
Vec2.__index = Vec2
Vec2_meta.__index = Vec2_meta

setmetatable(Vec2, Vec2_meta)

Vec2_meta.__call = function(self, x, y)
	return setmetatable({
		x = x or 0,
		y = y or 0,
	}, Vec2)
end

-- Vec2.__tostring = function (self)
-- 	return "Vec2 - X: "..self.x.." Y: "..self.y
-- end

Vec2.__newindex = function (self, key, value)
	error("Can't assign key '"..key.."', valid keys are 'x' & 'y'" )
end

Vec2.__add = function (a, b)
	if type(a) == "table" and type(b) == "table" then
		return Vec2(a.x + b.x, a.y + b.y)
	elseif type(a) == "table" then
		return Vec2(a.x + b, a.y + b)
	elseif type(b) == "table" then
		return Vec2(a + b.x, a + b.x)
	end
end

Vec2.__sub = function (a, b)
	if type(a) == "table" and type(b) == "table" then
		return Vec2(a.x - b.x, a.y - b.y)
	elseif type(a) == "table" then
		return Vec2(a.x - b, a.y - b)
	elseif type(b) == "table" then
		return Vec2(a - b.x, a - b.x)
	end
end

Vec2.__mul = function (a, b)
	if type(a) == "table" and type(b) == "table" then
		return Vec2(a.x * b.x, a.y * b.y)
	elseif type(a) == "table" then
		return Vec2(a.x * b, a.y * b)
	elseif type(b) == "table" then
		return Vec2(a * b.x, a * b.x)
	end
end

Vec2.__div = function (a, b)
	if type(a) == "table" and type(b) == "table" then
		return Vec2(a.x / b.x, a.y / b.y)
	elseif type(a) == "table" then
		return Vec2(a.x / b, a.y / b)
	elseif type(b) == "table" then
		return Vec2(a / b.x, a / b.x)
	end
end

function Vec2.copy(vec)
	return setmetatable({
		x = vec.x,
		y = vec.y,
	}, Vec2)
end

function Vec2:add(x, y)
	if type(x) == "table" then
		self.x = self.x + x.x
		self.y = self.y + x.y
	else
		self.x = self.x + (x)
		self.y = self.y + (y or x)
	end
	return self
end

function Vec2:div(x, y)
	if type(x) == "table" and x ~= 0 and y ~= 0 then
		self.x = self.x / x.x
		self.y = self.y / x.y
	else
		self.x = self.x / x
		self.y = self.y / (y or x)
	end
	return self
end

function Vec2:mul(x, y)
	if type(x) == "table" then
		self.x = self.x * x.x
		self.y = self.y * x.y
	else
		self.x = self.x * x
		self.y = self.y * (y or x)
	end
	return self
end

function Vec2:sub(x, y)
	if type(x) == "table" then
		self.x = self.x - x.x
		self.y = self.y - x.y
	else
		self.x = self.x - x
		self.y = self.y - (y or x)
	end
	return self
end

function Vec2:getPosition()
	return self.x, self.y
end

function Vec2:setPosition(x,y)
	self.x = x
	self.y = y
end

function Vec2:getDist_squared(other)
	local dx = self.x - other.x
	local dy = self.y - other.y
	return dx * dx + dy * dy
end

function Vec2:dist(other)
	return math.sqrt(self:getDist_squared(other))
end

function Vec2:getLength()
	return math.sqrt(self.x * self.x + self.y * self.y)
end

-- function math.clamp(v, lo, hi)
-- 	return math.max(lo, math.min(v, hi))
-- end

---Magnitude Squared
function Vec2:getMagSq()
	local x = self.x
	local y = self.y
	return x * x + y * y
end

function Vec2:setLimit_max(max)
	local mSq = self:getMagSq()
	if mSq > max * max then
		self:div(math.sqrt(mSq)):mul(max)
	end
	return self
end

function Vec2:setLimit_min(min)
	local mSq = self:getMagSq()
	if mSq < min * min then
		self:div(math.sqrt(mSq)):mul(min)
	end
	return self
end

function Vec2:normalise()
	local l = self:getLength()
	if l ~= 0 then
		self.x = self.x / l
		self.y = self.y / l
	else
		self.x = 0
		self.y = 0
	end
	return Vec2(self.x, self.y)
end

function Vec2.random2DVector()
	local angle = love.math.random() * (math.pi * 2)
	local x = math.cos(angle)
	local y = math.sin(angle)
	return x, y
end

function Vec2:atan2()
	return math.atan2(self.y, self.x)
end

function Vec2:setMag(n)
	self:normalise()
	self.x = self.x * n
	self.y = self.y * n
	return self
end

return Vec2