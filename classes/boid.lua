---@class Boid
---@field position any
---@field r number
---@field velocity any
---@field acceleration any
---@field maxSpeed number
---@field maxForceAlign number
---@field maxForceSeperate number
---@field maxForceCohesion number
local Boid = {}
Boid.__index = Boid
local Vec2 = require("lib.vec2")
function Boid.new(settings)
	local instance        = setmetatable({}, Boid)
	instance.position     = Vec2(love.math.random(WINDOW_WIDTH), love.math.random(WINDOW_HEIGHT))
	instance.r            = settings.r or 6
	instance.velocity     = Vec2(Vec2.random2DVector())
	instance.velocity:setMag(3)
	instance.acceleration = Vec2()
	instance.maxSpeed     = 5
	instance.maxForceAlign     = 1
	instance.maxForceSeperate     = 1.5
	instance.maxForceCohesion     = 0.02
	return instance
end

function Boid:align(boids)
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
		steering:limit(self.maxForceAlign)
	end
	return steering
end

function Boid:separation(boids)
	local perceptionRadius = 10
	local steering = Vec2()
	local total = 0

	for _, other in ipairs(boids) do
		local d = self.position:dist(other.position)
		if other ~= self and d < perceptionRadius then
			local diff = self.position - other.position
			diff:div(d * d)
			steering = steering + diff
			total = total + 1
		end
	end
	if total > 0 then
		steering = steering / total
		steering:setMag(self.maxSpeed)
		steering = steering - self.velocity
		steering:limit(self.maxForceSeperate)
	end
	return steering
end

function Boid:cohesion(boids)
	local perceptionRadius = 50
	local steering = Vec2()
	local total = 0

	for _, other in ipairs(boids) do
		local d = self.position:dist(other.position)
		if other ~= self and d < perceptionRadius then
			steering = steering + other.position
			total = total + 1
		end
	end
	if total > 0 then
		steering = steering / total
		steering = steering - self.position
		steering:setMag(self.maxSpeed)
		steering = steering - self.velocity
		steering:limit(self.maxForceCohesion)
	end
	return steering
end

function Boid:flock(boids)
	local alignment = self:align(boids)
	local cohesion = self:cohesion(boids)
	local separation = self:separation(boids)
	self.acceleration = self.acceleration + alignment
	self.acceleration = self.acceleration + cohesion
	self.acceleration = self.acceleration + separation
end

function Boid:update(dt)
	self.position = self.position + self.velocity * dt * 60
	self.velocity = self.velocity + self.acceleration * dt * 60
	self.velocity:limit(self.maxSpeed)
	self.acceleration = self.acceleration * 0

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