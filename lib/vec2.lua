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

Vec2.__tostring = function (self)
	return "Vec2 - X: "..self.x.." Y: "..self.y
end

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
	self.x = self.x + (x)
	self.y = self.y + (y or x)
	return self
end

function Vec2:div(x, y)
	self.x = self.x / x
	self.y = self.y / (y or x)
	return self
end

function Vec2:mul(x, y)
	self.x = self.x * x
	self.y = self.y * (y or x)
	return self
end

function Vec2:sub(x, y)
	self.x = self.x - x
	self.y = self.y - (y or x)
	return self
end

function Vec2:getPosition()
	return self.x, self.y
end

function Vec2:setPosition(x,y)
	self.x = x
	self.y = y
end

---Distance between two 2d vectors
---@param a table a = (x, y)
---@param b table b = (x, y)
---@return number length
function Vec2.dist(a, b)
	return math.sqrt((b.x * b.x - a.x * a.x) + (b.y * b.y - a.y * a.y))
end

function Vec2:length()
	return math.sqrt(self.x * self.x + self.y * self.y)
end

function math.clamp(v, lo, hi)
	return math.max(lo, math.min(v, hi))
end

function Vec2:limit(min, max)
	self.x = math.clamp(self.x, min, max)
	self.y = math.clamp(self.y, min, max)
	return self
end

function Vec2:normalise()
	return self:length() ~= 0 and Vec2(self.x / self:length(), self.y / self:length()) or Vec2(0,0)
end

function Vec2.random2DVector()
	local angle = love.math.random() * (math.pi * 2)
	local length = 1
	local x = length * math.cos(angle)
	local y = length * math.sin(angle)
	return x, y
end

function Vec2:setMag(n)
	self:normalise()
	self.x = self.x * n
	self.y = self.y * n
	return self
end

return Vec2