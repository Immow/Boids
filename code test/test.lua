local Vec2 = require("lib.vec2")
local maxSpeed = 5
local velocity = 3
local maxForce = 0.2

local VecA = {
	position = Vec2(5, 5),
	velocity = Vec2(1, 0.5),
	acceleration = Vec2(),
}
VecA.velocity:setMag(3)

local VecB = {
	position = Vec2(10, 5),
	velocity = Vec2(1, 0.5),
	acceleration = Vec2(),
}
VecB.velocity:setMag(3)
print("this")
print(VecB.velocity.x, VecB.velocity.y)

local function align()
	local perceptionRadius = 25
	local steering = Vec2()
	local total = 0

		local d = VecA.position:dist(VecB.position)
		print("local d = VecA.position:dist(VecB.position)")
		print(d)

		steering:add(VecB.velocity)
		print("steering:add(VecB.velocity)")
		print(steering)

		total = total + 1

		steering:div(total)
		print("steering:div(total)")
		print(steering:div(total))

		steering:setMag(maxSpeed)
		print(steering:setMag(maxSpeed))
		print("steering:setMag(maxSpeed)")

		steering:sub(velocity)
		print("steering:sub(velocity)")
		print(steering:sub(velocity))

		steering:limit_max(maxForce)
		print("steering:limit_max(maxForce)")
		print(steering:limit_max(maxForce))
	return steering
end


local function separation()
	local perceptionRadius = 24
	local steering = Vec2()
	local total = 0


	local d = VecA:dist(VecB)
	print(d)
	-- if VecB ~= self and d < perceptionRadius then
	-- 	local diff = self - VecB
	-- 	diff:div(d * d)
	-- 	steering:add(diff)
	-- 	total = total + 1
	-- end

	-- if total > 0 then
	-- 	steering:div(total)
	-- 	steering:setMag(self.maxSpeed)
	-- 	steering:sub(self.velocity)
	-- 	steering:limit_max(self.maxForceSeperate)
	-- end
	-- return steering
end
-- align()
-- separation()