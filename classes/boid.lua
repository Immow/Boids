---@class Boid
---@field position any
---@field r number
---@field velocity any
---@field acceleration any
---@field maxSpeed number
---@field maxForceAlign number
---@field maxForceSeperate number
---@field maxForceCohesion number
---@field minSpeed number
local Boid = {}
Boid.__index = Boid
local Vec2 = require("lib.vec2")
function Boid.new(settings)
	local instance            = setmetatable({}, Boid)
	instance.position         = Vec2(love.math.random(WINDOW_WIDTH), love.math.random(WINDOW_HEIGHT))
	instance.r                = settings.r or 3
	instance.velocity         = Vec2(Vec2.random2DVector())
	instance.velocity:setMag(love.math.random(2, 4))
	instance.acceleration     = Vec2()
	instance.maxSpeed         = 5
	instance.minSpeed         = 4
	instance.maxForceAlign    = 0.2
	instance.maxForceSeperate = 0.2
	instance.maxForceCohesion = 0.2
	return instance
end

function Boid:align(boids)
	local perceptionRadius = 25
	local steering = Vec2()
	local total = 0

	for _, other in ipairs(boids) do
		local d = self.position:dist(other.position)
		if other ~= self and d < perceptionRadius then
			steering:add(other.velocity)
			total = total + 1
		end
	end
	if total > 0 then
		steering:div(total)
		steering:setMag(self.maxSpeed)
		steering:sub(self.velocity)
		steering:setLimit_max(self.maxForceAlign)
	end
	return steering
end

function Boid:separation(boids)
	local perceptionRadius = 24
	local steering = Vec2()
	local total = 0

	for _, other in ipairs(boids) do
		local d = self.position:dist(other.position)
		if other ~= self and d < perceptionRadius then
			local diff = self.position - other.position
			diff:div(d * d)
			steering:add(diff)
			total = total + 1
		end
	end
	if total > 0 then
		steering:div(total)
		steering:setMag(self.maxSpeed)
		steering:sub(self.velocity)
		steering:setLimit_max(self.maxForceSeperate)
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
			steering:add(other.position)
			total = total + 1
		end
	end
	if total > 0 then
		steering:div(total)
		steering:sub(self.position)
		steering:setMag(self.maxSpeed)
		steering:sub(self.velocity)
		steering:setLimit_max(self.maxForceCohesion)
	end
	return steering
end

function Boid:flock(boids)
	-- self.acceleration:add(self:align(boids))
	-- self.acceleration:add(self:cohesion(boids))
	-- self.acceleration:add(self:separation(boids))

	local alignment = self:align(boids)
	local cohesion = self:cohesion(boids)
	local separation = self:separation(boids)

	alignment = alignment * SliderSettings["AlignmentFactor"]
	cohesion = cohesion * SliderSettings["CohesionFactor"]
	separation = separation * SliderSettings["SeparationFactor"]

	self.acceleration:add(alignment)
	self.acceleration:add(cohesion)
	self.acceleration:add(separation)
end

function Boid:update(dt)
	self.position:add(self.velocity)
	self.velocity:add(self.acceleration)
	self.velocity:setLimit_max(self.maxSpeed)
	self.acceleration:mul(0)

	-- if self.position.x > WINDOW_WIDTH or self.position.x < 0 then self.velocity.x = self.velocity.x * -1 end
	-- if self.position.y > WINDOW_HEIGHT or self.position.y < 0 then self.velocity.y = self.velocity.y * -1 end
	if self.position.x > WINDOW_WIDTH then self.position.x = 0 end
	if self.position.x < 0 then self.position.x = WINDOW_WIDTH end
	if self.position.y > WINDOW_HEIGHT then self.position.y = 0 end
	if self.position.y < 0 then self.position.y = WINDOW_HEIGHT end
end

function Boid:drawBoid()
	love.graphics.circle("fill", self.position.x, self.position.y, self.r)
end

function Boid:draw()
	self:drawBoid()
end

return Boid