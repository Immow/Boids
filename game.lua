local Game = {boids = {}}

local Boid = require("classes.boid")

local boidAmount = 100

function Game:spawnBoid(n)
	for i = 1, n do
		table.insert(self.boids, Boid.new({}))
	end
end

function Game:load()
	self:spawnBoid(boidAmount)
end

function Game:mousepressed(mx, my, mouseButton)

end

function Game:mousereleased(x,y,button,istouch,presses)

end

function Game:keypressed(key,scancode,isrepeat)
	if scancode == "space" then
		love.event.quit("restart")
	end
end

function Game:draw()
	local totalXVelocity = 0
	local totalYVelocity = 0
	for i, boid in ipairs(self.boids) do
		if i == 1 then
			love.graphics.setColor(1,0,0)
		else
			love.graphics.setColor(1,1,1)
		end
		boid:draw()
		love.graphics.setColor(1,1,1)
		totalXVelocity = totalXVelocity + boid.velocity.x
		totalYVelocity = totalYVelocity + boid.velocity.y
	end
	love.graphics.print(totalXVelocity / boidAmount, 5)
	love.graphics.print(totalYVelocity / boidAmount, 5, 20)
end

function Game:update(dt)
	for _, boid in ipairs(self.boids) do
		boid:flock(self.boids, dt)
		boid:update(dt)
	end
end

return Game