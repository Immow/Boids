local Game = {boids = {}}
local Boid = require("classes.boid")

function Game:spawnBoid(n)
	for i = 1, n do
		table.insert(self.boids, Boid.new({}))
	end
end

function Game:load()
	self:spawnBoid(BoidAmount)
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
	love.graphics.print("Average Xvel.: "..totalXVelocity / BoidAmount, 5)
	love.graphics.print("Average Yvel.: "..totalYVelocity / BoidAmount, 5, 20)
	love.graphics.print("FPS: "..love.timer.getFPS(), 5, 40)
end

function Game:update(dt)
	for _, boid in ipairs(self.boids) do
		boid:flock(self.boids)
		boid:update(dt)
	end
	love.timer.sleep(1/60)
end

return Game