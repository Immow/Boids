local Game = {boids = {}}

local Boid = require("classes.boid")

local boidAmount = 50

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
	for _, boid in ipairs(self.boids) do
		boid:draw()
	end
end

function Game:update(dt)
	for _, boid in ipairs(self.boids) do
		boid:flock(self.boids)
		boid:update(dt)
	end
end

return Game