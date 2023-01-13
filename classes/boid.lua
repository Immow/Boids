-- FUNCTION TO PRINT TABLES
function tprint (tbl, indent)
	if not indent then indent = 0 end
	local toprint = string.rep(" ", indent) .. "{\r\n"
	indent = indent + 2 
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if (type(k) == "number") then
			toprint = toprint .. "[" .. k .. "] = "
		elseif (type(k) == "string") then
			toprint = toprint  .. k ..  "= "   
		end
		if (type(v) == "number") then
			toprint = toprint .. v .. ",\r\n"
		elseif (type(v) == "string") then
			toprint = toprint .. "\"" .. v .. "\",\r\n"
		elseif (type(v) == "table") then
			toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
		else
			toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
		end
	end
	toprint = toprint .. string.rep(" ", indent-2) .. "}"
	return toprint
end

---@class Boid
---@field position any
---@field r number
---@field velocity any
---@field acceleration any
---@field maxForce number
---@field maxSpeed number
local Boid = {}
Boid.__index = Boid
local Vec2 = require("lib.vec2")
function Boid.new(settings)
	local instance        = setmetatable({}, Boid)
	instance.position     = Vec2(love.math.random(WINDOW_WIDTH), love.math.random(WINDOW_HEIGHT))
	instance.r            = settings.r or 10
	instance.velocity     = Vec2(Vec2.random2DVector())
	instance.acceleration = Vec2()
	instance.velocity:setMag(3)
	instance.maxSpeed = 5
	instance.maxForce = 0.2
	return instance
end

function Boid:alignBoids(boids)
	local perceptionRadius = 50
	local steering = Vec2()
	local total = 0

	for _, other in ipairs(boids) do
		local d = self.position:dist(other.position)
		if other ~= self and d < perceptionRadius then
			steering = steering + other.velocity
			total = total + 1
		end
	end
	if total > 0 then
		steering = steering / total
		steering:setMag(self.maxSpeed)
		steering = steering - self.velocity
		steering:limit(self.maxForce)
	end
	return steering
end

function Boid:flock(boids)
	local alignment = self:alignBoids(boids)
	self.acceleration = alignment
end

function Boid:update(dt)
	self.position = self.position + self.velocity * dt * 60
	self.velocity = self.velocity + self.acceleration

	-- if self.position.x > WINDOW_WIDTH or self.position.x < 0 then self.velocity.x = self.velocity.x * -1 end
	-- if self.position.y > WINDOW_HEIGHT or self.position.y < 0 then self.velocity.y = self.velocity.y * -1 end
	if self.position.x > WINDOW_WIDTH then self.position.x = 0 end
	if self.position.x < 0 then self.position.x = WINDOW_WIDTH end
	if self.position.y > WINDOW_HEIGHT then self.position.y = 0 end
	if self.position.y < 0 then self.position.y = WINDOW_HEIGHT end
end

function Boid:drawBoid()
	love.graphics.circle("line", self.position.x, self.position.y, self.r)
end

function Boid:draw()
	-- love.graphics.print(self.velocity:length(), self.position.x, self.position.y)
	-- love.graphics.print(math.floor(self.velocity.y), self.position.x, self.position.y+5)
	self:drawBoid()
end

return Boid